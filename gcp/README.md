
# Google Cloud Platform

Spins up a series of VMs with the fraud-scoring example deployed, with
Renjin or OpenCPU.

## Setup

Before you can run `terraform`, you have to do setup permissions and your
environment.

First, create and download a JSON service key as described in the 
[Google Cloud Provider](https://www.terraform.io/docs/providers/google/index.html#authentication-json-file) documentation.

Then, set the following environment variables:

```
export GOOGLE_CREDENTIALS=`cat ~/.keys/myaccount.json
export GOOGLE_PROJECT=renjin-perf-testing
```

Second, you need to add your private key to the Project so that Terraform's
`remote-exec` provisioner can connect automatically to the newly created
instances. Copy and paste the text from `~/.ssh/id_rsa.pub` into the Google
Compute Console [SSH Keys](https://console.cloud.google.com/compute/metadata/sshKeys) list.

## Applying

From the project root directory, run:

```
terraform apply gcp
```
