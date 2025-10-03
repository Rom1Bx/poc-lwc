# SALESFORCE POC

The goal is to have a way to develop locally a Lightning Web Component which will be later integrated in SalesForce.

## How to setup :

### If you are here for the first time :
- Signup here https://www.salesforce.com/form/developer-signup/?d=pb (not working on firefox for the moment)
- Install [salesforce cli](https://developer.salesforce.com/docs/atlas.en-us.sfdx_setup.meta/sfdx_setup/sfdx_setup_install_cli.htm)
- Login to your org via shell using web `sf org login web --alias DevHub --set-default-dev-hub`
- Activate dev hub in your org : Log in to your org → setup → dev hub (enable)

### If you already have read the notion page :
- Use the make command (this will create a scratch org and deploy the repo to it)

```json
make scratch-create NAME=<feature_name> DAYS=<number of days you want this scratch to be active max 7>
```
