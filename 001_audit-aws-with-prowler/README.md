# Audit AWS Account with Prowler

In this lab we will use an open source tool called [Prowler](https://github.com/prowler-cloud/prowler) to  audit an AWS account for configuration and security improvements.

# Requirements

- python ">=3.10,<3.13"
- prowler "3.15.0"
- awscli ">=1.18.69"
- poetry "1.7.1" (optional)

# Lab

## Previous Steps

You can install Prowler by using the pip command or by using the poetry command to install dependencies in *pyproject.toml*.

```sh
poetry install

pip install prowler==3.15.0
```

We need to check that we have Prowler installed on our workstation.

```sh
user@Lenovo-V15:~$ prowler --version
Prowler 3.15.0 (latest is 3.15.1, upgrade for the latest features)
```

## Steps

- Create an AWS group with the following policies.

```
arn:aws:iam::aws:policy/SecurityAudit
arn:aws:iam::aws:policy/job-function/ViewOnlyAccess
```

![001.1 Audit group to use prowler](images/001.1_audit_group.png)

- Create an AWS user with and membership in the previous group.
- Create an AWS access keys for prowler_user.
- Configure aws profile audit with prowler_user access keys.

```sh
user@Lenovo-V15:~$ aws configure --profile audit
AWS Access Key ID [None]: <access-key-id>
AWS Secret Access Key [None]: <secret-access-key>
Default region name [None]: us-east-1
Default output format [None]: json
```

- Run the prowler command with the following parameters.

```sh
user@Lenovo-V15:~$ prowler aws --profile audit --region us-east-1 -F index -o reports
```

- View Prowler html report and filter by FAIL status

![001.2 Prowler report filter](images/001.2_prowler_report_filter.png)

- Fix some checks and re-run Prowler's previous command again to verify.

![001.3 Prowler new report](images/001.3_prowler_new_report.png)
