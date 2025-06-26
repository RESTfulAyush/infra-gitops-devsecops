output "ecr_repo_url" {
  value = module.ecr.ecr_repo_url
}

output "github_actions_role_arn" {
  value = module.ci_iam.github_actions_role_arn
}
