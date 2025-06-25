output "project_repository" {
  value = {
    url            = module.version_control_system.project_repository.html_url
    http_clone_url = module.version_control_system.project_repository.http_clone_url
  }
}
