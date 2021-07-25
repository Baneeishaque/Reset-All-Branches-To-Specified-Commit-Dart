import 'dart:io';

String getGitVersion() {
  return Process.runSync('git', ['--version']).stdout;
}

List<String> getGitBranchesAll(String repoDirectory) {
  var processResult = Process.runSync('git', ['branch', '--all'],
      workingDirectory: repoDirectory);
  var gitBranches = processResult.stdout
      .toString()
      .replaceFirst('*', '')
      .split('\n')
      .map((e) => e.trimLeft())
      .toList();
  gitBranches.removeLast();
  return gitBranches;
}

List<String> getGitBranchesInLocal(String repoDirectory) {
  var processResult =
      Process.runSync('git', ['branch'], workingDirectory: repoDirectory);
  var gitBranchesInLocal = processResult.stdout
      .toString()
      .replaceFirst('*', '')
      .split('\n')
      .map((e) => e.trimLeft())
      .toList();
  gitBranchesInLocal.removeLast();
  return gitBranchesInLocal;
}

//TODO : Use command from git
List<String> getGitBranchesInRemote(String repoDirectory,
    {String remoteName = 'origin'}) {
  // print(getGitBranchesAll(repoDirectory));
  return getGitBranchesAll(repoDirectory)
      .where((element) =>
          element.contains('remotes') && (!element.contains('HEAD ->')))
      .map((e) => e.replaceFirst('remotes/' + remoteName + '/', ''))
      .toList();
}

void createMissingBranchesInLocal(String repoDirectory,
    {remoteName = 'origin'}) {
  getMissingBranchesInLocal(repoDirectory, remoteName: remoteName)
      .forEach((element) {
    Process.runSync('git', ['branch', element, remoteName + '/' + element],
        workingDirectory: repoDirectory);
  });
}

List<String> getMissingBranchesInLocal(String repoDirectory,
    {remoteName = 'origin'}) {
  return getGitBranchesInRemote(repoDirectory, remoteName: remoteName)
      .toSet()
      .difference(getGitBranchesInLocal(repoDirectory).toSet())
      .toList();
}

void gitMergeSpecifiedBranchWithOtherBranches(
    String repoDirectory, String desiredBranch,
    {remoteName = 'origin'}) {
  createMissingBranchesInLocal(repoDirectory, remoteName: remoteName);
  getGitBranchesInLocal(repoDirectory).forEach((element) {
    if (element != desiredBranch) {
      Process.runSync('git', ['push', '.', desiredBranch + ':' + element],
          workingDirectory: repoDirectory);
    }
  });
}
