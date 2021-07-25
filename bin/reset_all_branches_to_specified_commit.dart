import 'package:args/args.dart';
import 'package:reset_all_branches_to_specified_commit/reset_all_branches_to_specified_commit.dart'
    as reset_all_branches_to_specified_commit;

void main(List<String> arguments) {
  var repoDirectoryArgument = 'repoDirectory';
  var desiredBranchArgument = 'desiredBranch';
  var parser = ArgParser();
  parser.addOption(repoDirectoryArgument);
  parser.addOption(desiredBranchArgument);
  var suppliedArguments = parser.parse(arguments);
  if (suppliedArguments.wasParsed(repoDirectoryArgument)) {
    if (suppliedArguments.wasParsed(desiredBranchArgument)) {
      // var repoDirectory = '/workspace/VS2019-Azure-DevOps';
      // var desiredBranch = 'ManagedDesktop';
      var repoDirectory = suppliedArguments[repoDirectoryArgument];
      var desiredBranch = suppliedArguments[desiredBranchArgument];
      reset_all_branches_to_specified_commit
          .createMissingBranchesInLocal(repoDirectory);
      print(reset_all_branches_to_specified_commit
          .getGitBranchesInRemote(repoDirectory));
      print(reset_all_branches_to_specified_commit
          .getGitBranchesInLocal(repoDirectory));
      reset_all_branches_to_specified_commit
          .gitMergeSpecifiedBranchWithOtherBranches(
              repoDirectory, desiredBranch);
    } else {
      print('Please Supply desiredBranch');
    }
  } else {
    print('Please Supply repoDirectory');
  }
}
