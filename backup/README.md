## Automatically backup OpenWRT to Nextcloud instance

With this script, you can backup your OpenWRT router and upload to a Nextcloud instance of your preference.

You need to create an app token for your Nextcloud account. Simply go to Personal Settings > Security and generate a new one. 

To use it, download it, change the variables to your own ones, and put in your script folder in your OpenWRT. You should also execute `chmod +x backup-to-nextcloud.sh` to set permissions correctly.

Then, if you want to do it automatically, just put in the Scheduled tasks with the frequence you like!

For instance, the following example will execute the backup every day at 2 am.

`0 2 * * * /path/to/script/backup-to-nextcloud.sh`
