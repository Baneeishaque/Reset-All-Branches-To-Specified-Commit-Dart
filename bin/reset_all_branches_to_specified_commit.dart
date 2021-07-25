import 'package:reset_all_branches_to_specified_commit/reset_all_branches_to_specified_commit.dart'
    as reset_all_branches_to_specified_commit;

void main(List<String> arguments) {
  var repoDirectory = '/workspace/VS2019-Azure-DevOps';
  var desiredBranch = 'ManagedDesktop';
  reset_all_branches_to_specified_commit
      .createMissingBranchesInLocal(repoDirectory);
  print(reset_all_branches_to_specified_commit
      .getGitBranchesInRemote(repoDirectory));
  print(reset_all_branches_to_specified_commit
      .getGitBranchesInLocal(repoDirectory));
  reset_all_branches_to_specified_commit
      .gitMergeSpecifiedBranchWithOtherBranches(repoDirectory, desiredBranch);
}
