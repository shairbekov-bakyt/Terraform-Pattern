provider "aws" {
  region = "us-east-1"
}

resource "aws_cognito_user_pool" "exampleUserPool" {
  name                     = "exampleUserPool"
  auto_verified_attributes = ["email"]
  username_attributes      = ["email"]
  verification_message_template {
    default_email_option = "CONFIRM_WITH_LINK"

  }
  password_policy {
    minimum_length    = 8
    require_lowercase = true
  }
  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
  }
}

resource "aws_cognito_user_pool_client" "exampleApp" {
  name            = "exampleApp"
  generate_secret = false
  user_pool_id    = aws_cognito_user_pool.exampleUserPool.id
}

resource "aws_cognito_user_pool_domain" "exampleDomain" {
  domain = "zeonithub312292"
  user_pool_id = aws_cognito_user_pool.exampleUserPool.id
}