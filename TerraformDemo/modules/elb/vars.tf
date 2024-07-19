# Defining project Tag
variable "project" {
    type = string
    default = "jtrinh"
}

variable "vpc_id"{
    type = string
}

variable "subnet_ids"{
    type = list(string)
}