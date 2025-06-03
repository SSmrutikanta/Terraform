# AWS Infrastructure Setup with Terraform

This Terraform configuration provisions the following infrastructure on AWS:

- A custom VPC
- Two public subnets across different availability zones
- An Internet Gateway and Route Table
- A Security Group with HTTP and SSH access
- Two EC2 instances acting as web servers
- An Application Load Balancer (ALB) with a listener
- Target Group with both EC2 instances registered
- An S3 bucket
- Outputs the ALB DNS name

---

## Prerequisites

Before using this Terraform configuration, ensure you have:

- An AWS account with required permissions (EC2, VPC, S3, ALB)
- Terraform v1.x or later installed
- AWS CLI configured (`aws configure`)
- Two user data scripts: `userdata.sh` and `userdata1.sh` in the same directory
- (Optional) A valid SSH key pair if needed to access the EC2 instances

---

## File Structure

├── main.tf # Terraform configuration
├── userdata.sh # User data script for webserver1
├── userdata1.sh # User data script for webserver2
├── variables.tf # Input variables for Terraform
├── terraform.tfvars # (Optional) Custom variable values
└── README.md # This documentation



---

## Usage

### 1. Clone the Repository

```bash
git clone <your-repo-url>
cd <repo-directory>


2. Initialize Terraform
terraform init
3. Validate Configuration
terraform validate
4. Apply the Configuration
terraform apply


Outputs
After deployment, the following output will be displayed:

loadbalancerdns – The DNS name of the Application Load Balancer

You can access the web servers using this DNS in your browser (ensure the user data scripts configure a web server like Apache or Nginx).

Notes
The EC2 instances are launched in two different subnets (AZs) for high availability.

Security Group allows:

HTTP (port 80) from anywhere

SSH (port 22) from anywhere — for production, consider restricting this.

The ALB listens on port 80 and forwards traffic to both EC2 instances.

The S3 bucket name is hardcoded as devopssmrutiproject — ensure this name is globally unique to avoid errors.

Cleanup
To destroy all created resources:

bash
Copy
Edit
terraform destroy
Type yes when prompted.


