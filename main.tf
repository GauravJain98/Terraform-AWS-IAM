provider "aws" {
  region     = "us-east-1"
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
}

# Main IAM User
resource "aws_iam_user" "user" {
  name = "${var.prefix}-user"
}

# Policy document to create trust relationship 
data "aws_iam_policy_document" "policy_document" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]
    principals {
      type        = "AWS"
      identifiers = [aws_iam_user.user.arn]
    }
  }
}

# Policy role which which can be assumed
resource "aws_iam_role" "role" {
  name               = "${var.prefix}-role"
  assume_role_policy = data.aws_iam_policy_document.policy_document.json
}

# IAM group which will be used by the user
resource "aws_iam_group" "group" {
  name = "${var.prefix}-group"
  path = "/"
}

# Attaching user to group 
resource "aws_iam_group_membership" "group_membership" {
  name = "${var.prefix}-group_membership"

  users = [
    aws_iam_user.user.name,
  ]

  group = aws_iam_group.group.name
}

