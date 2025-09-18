output "vpc_id" {
  value = module.vpc.vpc_id
}

output "subnet_ids" {
#   value = module.vpc.subnet_ids
  value = module.vpc.subnets_ids
}

output "ec2_instance_id" {
  value = module.ec2.instance_id
}

output "rds_instance_id" {
#   value = module.rds.db_instance_id
    value = module.rds.aws_db_instance_id
}

output "s3_website_url" {
    description = "s3 static website"
    value = module.s3.s3_website_endpoint
  
}

output "grafana" {
    
    value = "http://${module.ec2.instance_id}:3000"
}

output "prometheus_url" {
  value = "http://${module.ec2.instance_id}:9090"
}
