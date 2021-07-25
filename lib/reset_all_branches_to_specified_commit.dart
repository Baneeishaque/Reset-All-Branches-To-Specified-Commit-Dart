import 'dart:io';

int calculate() {  
  return 6 * 7;
}

void printGitVersion() async {
  var result = await Process.run('git', ['--version']);
  stdout.write(result.stdout);
  stderr.write(result.stderr);
}

void printGitBranches(String repoDirectory) async {
  var result = await Process.run('git', ['branch'], workingDirectory: repoDirectory);
  // var result = await Process.run('git', ['branch']);
  stdout.write(result.stdout);
  stderr.write(result.stderr);
}
