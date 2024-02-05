variable "env_name" {
  type    = string
  default = null
  }

variable "subnets" {
   type = list(object({
    zone = string,
    cidr = string
    }))
  default     = []
}