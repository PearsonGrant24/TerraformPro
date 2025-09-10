variable "allocated_storage" {
    description = "size the db in GB"
    type = number
}

variable "storage_type" {
  description = "storage type"
  type = string
}

variable "engine" {
  description = "DB engine to use -- "
  type =  string
}

variable "engine_version" {
  description = "the version of the db"
  type = string
}

variable "instance_class" {
  description = "the compute and memory capacity"
  type = string
}

variable "db_identifier" {
    description = "the identifier"
    type = string  
}

variable "username" {
    description = "username for the DB"
    type = string
}

variable "password" {
  description = "password for the DB"
  type = string
  sensitive = true
}

variable "parameter_group_name" {
    description = "parameter group to associate with"
  
}