terraform {
  required_providers {
    github = {
      source = "integrations/github"
      version = "6.6.0"
    }
  }
}

variable "github_token" {
  description = "The project's GitHub API token"
  sensitive = true
}
provider "github" {
  token = var.github_token
}
