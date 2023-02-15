<h1 align="center"> SAECTL </h1>

## Introduction
AliCloud [Serverless App Engine (SAE)](https://www.alibabacloud.com/product/severless-application-engine) is an Application-Oriented Serverless PaaS, providing a Fully-Managed Infrastructure (IaaS, Kubernetes, Microservice Components, and APM Components). While in some CD scene, developers would like to manage SAE resources in a more kubectl-like way. The saectl provides a similar experience like kubectl to interact with SAE.

## CLI Releases
The release notes for the CLI can be found in the [Releases](https://github.com/devsapp/saectl/releases).

## Installation

- **Download installer (Recommended)**
  Download the installer, then extract the installer. You can move the extracted `saectl` executable file to the `/usr/local/bin` directory or add it to the `$PATH`.

  Download link: (<img src="https://img.shields.io/github/release/devsapp/saectl.svg" alt="Latest Stable Version" />)

  - [Mac (AMD64)](https://sae-component-software.oss-cn-hangzhou.aliyuncs.com/saectl/latest/saectl-latest-darwin-amd64.tar.gz)
  - [Mac (ARM64)](https://sae-component-software.oss-cn-hangzhou.aliyuncs.com/saectl/latest/saectl-latest-darwin-arm64.tar.gz)
  - [Linux (AMD64)](https://sae-component-software.oss-cn-hangzhou.aliyuncs.com/saectl/latest/saectl-latest-linux-amd64.tar.gz)
  - [Linux (ARM64)](https://sae-component-software.oss-cn-hangzhou.aliyuncs.com/saectl/latest/saectl-latest-linux-arm64.tar.gz)
  - [Windows (AMD64)](https://sae-component-software.oss-cn-hangzhou.aliyuncs.com/saectl/latest/saectl-latest-windows-amd64.tar.gz)
  - [Windows (ARM64)](https://sae-component-software.oss-cn-hangzhou.aliyuncs.com/saectl/latest/saectl-latest-windows-arm64.tar.gz)

  All releases please [click here](https://github.com/devsapp/saectl/releases).

- **Use install script(only support Linux/MacOs)**

  You can run the flowing command:
  ```
  sudo curl -s https://sae-component-software.oss-cn-hangzhou.aliyuncs.com/saectl/install.sh | bash
  ```

## Configure

Before using SAECTL to invoke the services, you need to configure the credential information, region, etc.
You can run the flowing commands for quick configuration.

```
export ALICLOUD_REGION=cn-beijing
export ALICLOUD_ACCESS_KEY=XXXXXXXXXXXX
export ALICLOUD_SECRET_KEY=XXXXXXXXXXXX
```

## Use Alibaba Cloud CLI

### Get SAE Namespace

```
saectl get ns
```

### Get SAE Application
```
saectl get deploy
```

### Access SAE Instance Terminal
```
saectl exec test-697a5776-0f2a-4165-a55e-8ceff2140201-6w6t5 -it -- /bin/bash
```

### More 

more information, please read [docs of SAE](https://help.aliyun.com/document_detail/475875.html). 
