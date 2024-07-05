# Overview

# Instructions

1. Initialize the working directory

Run the following command:

`terraform init`

Take note that it initialized the backend and downloaded the random provider.

2. Validate the code

Run the following command:

`terraform validate`

3. Verify you are in the `default` workspace

Run the following command:

`terraform workspace show`

Take note that it says `default`

2. Now create a workspace for `dev`

Run the following command:

`terraform workspace new dev`

3. Create a workspace for `prod`

Run the following command:

`terraform workspace new prod`

4. Switch back to `dev`

Run the following command:

`terraform workspace select dev`

5. Verify you are on the `dev` workspace

Run the following command:

`terraform workspace show`

Take note that it says `dev`

6. Run plan on dev

Run the following command:

`terraform apply -var-file="./env/dev.tfvars" -auto-approve`

Take note of the `dynamic_name` output. Observe that it has the prefix of `dev`. Also take note of the `workspace_name` output. Observe that it has the value of `dev`.

7. Switch to `prod`

Run the following command:

`terraform workspace select prod`

8. Verify you are on `prod`

Run the following command:

`terraform workspace show`

Take note that it says `prod`

9. Run apply on prod

Run the following command:

`terraform apply -var-file="./env/prod.tfvars" -auto-approve`

Take note of the `dynamic_name` output. Observe that it has the prefix of `prod` and a different four character suffix than the same value for `dev`. Also take note of the `workspace_name` output. Observe that it has the value of `prod`.