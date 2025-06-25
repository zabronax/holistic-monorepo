resource "github_repository" "project_repository" {
  name = "holistic-monorepo"

  visibility         = "public"
  archive_on_destroy = false

  # Metadata
  description  = "An experiment in holistic monorepo management"
  homepage_url = null
  topics = [
    "monorepo",
    "nix",
    "gitops",
    "experimental",
    "work-in-progress"
  ]

  # Features
  has_issues      = false
  has_projects    = false
  has_wiki        = false
  has_discussions = false

  # Initialization
  auto_init = false
}

output "project_repository" {
  value = github_repository.project_repository
}
