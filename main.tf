terraform {
  required_providers {
    vultr = {
      source = "vultr/vultr"
      version = "2.17.1"
    }
  }
}

# Configure the Vultr Provider
provider "vultr" {
  api_key = "SILLVA2A6J3F6S4SKKSNXAPFNZFMWNFF2MRA"
  rate_limit = 100
  retry_limit = 3
}

resource "vultr_instance" "web" {
  region = "fra"
  plan = "vc2-1c-1gb"
  os_id = "381"

  user_data  = <<-EOF
    sudo apt-get update
    sudo apt-get install -y docker.io
    sudo systemctl start docker
    sudo systemctl enable docker
    sudo docker run -d -p 80:80 satzisa/html5-speedtest
  EOF
  tags = ["Test.chiant"]
}

output "instance_ip" {
  value = vultr_instance.web.main_ip
}