variable "yc_token" {
  description = "Yandex Cloud OAuth or IAM token"
  type        = string
  sensitive   = true
}

variable "yc_cloud_id" {
  description = "Yandex Cloud ID"
  type        = string
  sensitive   = true
}

variable "yc_folder_id" {
  description = "Yandex Cloud Folder ID"
  type        = string
  sensitive   = true
}

variable "yc_zone" {
  description = "Yandex Cloud zone"
  type        = string
  default     = "ru-central1-a"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "development"
  
  validation {
    condition     = contains(["development", "staging", "production"], var.environment)
    error_message = "Environment must be: development, staging, or production."
  }
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "finance_oltp"
}

variable "db_username" {
  description = "Database username"
  type        = string
  default     = "finance_admin"
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
  default     = "password"
}

variable "db_disk_size" {
  description = "Database disk size for development/staging (GB)"
  type        = number
  default     = 20
}

variable "db_prod_disk_size" {
  description = "Database disk size for production (GB)"
  type        = number
  default     = 100
}