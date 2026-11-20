# Putting the site live on Azure

The old Azure web app and database were deleted, so these steps create new ones.
It takes about 20 minutes, all in the Azure portal (https://portal.azure.com) and on GitHub.

## 1. Create the database
1. In the Azure portal, search for **SQL databases** and click **+ Create**.
2. **Resource group:** create a new one, for example `DanceStudioRG`.
3. **Database name:** `DanceStudio`.
4. **Server:** click **Create new**.
   - Server name: for example `10thavestudio-sql` (it must be unique worldwide).
   - Location: **Southeast Asia**.
   - Authentication: **Use SQL authentication**. Pick an admin login and a strong password, and save both.
5. **Workload environment:** Development. Under **Compute + storage**, choose **Basic** or the free serverless offer if it's shown.
6. On the **Networking** tab, set **Allow Azure services and resources to access this server** to **Yes**, and add your current client IP.
7. Click **Review + create**, then **Create**.

## 2. Create the tables
1. Open the new database and click **Query editor**. Sign in with the SQL login from step 1.
2. Paste the whole of [`Database/schema.sql`](../Database/schema.sql) and click **Run**.

## 3. Create the web app
1. Search for **App Services**, click **+ Create**, then **Web App**.
2. Use the same resource group.
3. **Name:** `10thAveStudio`, so the site is at `10thavestudio.azurewebsites.net`. If that name is taken, pick another and set it in `AZURE_WEBAPP_NAME` at the top of `.github/workflows/deploy-azure.yml`.
4. **Publish:** Code. **Runtime stack:** **ASP.NET V4.8**. **Operating system:** **Windows**. **Region:** Southeast Asia.
5. **Pricing plan:** **Free F1** is enough to start.
6. Click **Review + create**, then **Create**.
7. Open the web app, then go to **Settings > Configuration > General settings**. Turn **SCM Basic Auth Publishing Credentials** on and click **Save**.
8. On the web app's **Overview** page, click **Download publish profile**.

## 4. Add the GitHub secrets
In the GitHub repo, go to **Settings > Secrets and variables > Actions > New repository secret** and add:

| Name | Value |
|---|---|
| `AZURE_WEBAPP_PUBLISH_PROFILE` | The entire contents of the downloaded `.PublishSettings` file |
| `SQL_CONNECTION_STRING` | `Server=tcp:<server-name>.database.windows.net,1433;Initial Catalog=DanceStudio;User ID=<sql-login>;Password=<sql-password>;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;` |

## 5. Deploy
In GitHub, go to **Actions > Deploy to Azure > Run workflow**. When it turns green, open https://10thavestudio.azurewebsites.net.

## 6. Make yourself an admin
Sign up on the live site. Then run this in the database's Query editor:

```sql
UPDATE Users SET Role = 'Admin' WHERE Email = 'your-email@example.com';
```

After that, every push to `main` redeploys the site automatically.
