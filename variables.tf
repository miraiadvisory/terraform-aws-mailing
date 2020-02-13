variable "sesDomain" {
  description = "Domain for creating SES"
  default     = ""
  type        = string
}

variable "zone_id" {
  description = "ID from the Route53 zone where we're going to create the DNS records for SES"
  default     = ""
  type        = string
}

variable "bounce_topic_arn" {
  description = "arn of SNS topic to subscribe"
  default     = ""
  type        = string
}

variable "complaint_topic_arn" {
  description = "arn of SNS topic to subscribe"
  default     = ""
  type        = string
}

variable "bounce_headers" {
  description = "Option to include original headers when sent to SNS"
  default     = false
  type        = bool
}

variable "complaint_headers" {
  description = "Option to include original headers when sent to SNS"
  default     = false
  type        = bool
}

variable "notification_type" {
  description = "Valid Values: Bounce, Complaint or Delivery"
  default     = ""
  type        = string
}