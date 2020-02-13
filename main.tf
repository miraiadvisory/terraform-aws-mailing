resource "aws_ses_domain_identity" "ses_domain" {
  domain = var.sesDomain
}

resource "aws_ses_domain_dkim" "dkim_domain" {
  domain = aws_ses_domain_identity.ses_domain.domain
}

resource "aws_route53_record" "ses_verification_record" {
  zone_id = var.zone_id
  name    = "_amazonses.${aws_ses_domain_identity.ses_domain.domain}"
  type    = "TXT"
  ttl     = "600"
  records = [aws_ses_domain_identity.ses_domain.verification_token]
}

resource "aws_route53_record" "dkim_verification_record" {
  count   = 3
  zone_id = var.zone_id
  name    = "${element(aws_ses_domain_dkim.dkim_domain.dkim_tokens, count.index)}._domainkey.${aws_ses_domain_identity.ses_domain.domain}"
  type    = "CNAME"
  ttl     = "600"
  records = ["${element(aws_ses_domain_dkim.dkim_domain.dkim_tokens, count.index)}.dkim.amazonses.com"]
}

resource "aws_ses_identity_notification_topic" "bounce_notification" {
  topic_arn                = var.bounce_topic_arn
  notification_type        = "Bounce"
  identity                 = aws_ses_domain_identity.ses_domain.domain
  include_original_headers = var.bounce_headers
}

resource "aws_ses_identity_notification_topic" "complaint_notification" {
  topic_arn                = var.complaint_topic_arn
  notification_type        = "Complaint"
  identity                 = aws_ses_domain_identity.ses_domain.domain
  include_original_headers = var.complaint_headers
}