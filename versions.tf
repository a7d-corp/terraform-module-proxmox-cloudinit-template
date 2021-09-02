terraform {
  # minimum required version for experimental features.
  required_version = ">= 0.14.0"

  # enable experimental optional variables.
  # TODO: remove when no longer experimental.
  experiments = [module_variable_optional_attrs]
}
