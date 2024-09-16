# Dyno Scp

Heroku doesnt allow you to scp a file up to their server. This gem creates a
barebones file upload mechanism that dumps a file uploaded into the public
directory. Heroku automatically cleans that directory regularly so we dont have
to worry about files lingering around.

## Contents

- [Getting Started](#getting-started)
- [Tips](#tips)
- [Uploading A File](#uploading-a-file)
- [Accessing Uploaded Files](#accessing-uploaded-files)

## Getting Started

Add this line to your application's Gemfile:

```ruby
gem "dyno_scp", "~> <version>"
```

And then execute:

    $ bundle

Mount the engine in your routes file:

```ruby
mount DynoScp::Engine, at: "/dyno_scp"
```

### Tips

Heroku runs processes in their own separate dynos. If you add a file in your
console session and then exit and re-enter your file will be gone. This becomes
and issue when using this tool because when you upload a file it is placed in
the web dyno which you can't directly access.

See [Accessing Uploaded Files](#accessing-uploaded-files) for retrieval steps.

## Uploading A File

##### Note: The upload page requires the user to have an office:sys_admin role
After mounting the engine, you can navigate to `#{host}/dyno_scp` to see the upload page.

Simply choose the file you wish to upload, then press the "upload" button. You
will see a confirmation message once the file has been uploaded.

Files are placed in the `/public` folder, so use this with caution. They will
be publicly accessible to anyone who finds out they exist.

In Heroku, these files are cleared out every 24 hours automatically. In other
hosting schemes, there may not be automated cleanup of the public folder.

## Accessing Uploaded Files

The main use case for this tool is to upload a file to a heroku hosted site
for usage in some type of data load or backfill task.

After setting up open a bash console on the heroku app.
```bash
heroku run bash --app my-heroku-app
```

To use files after they've been uploaded with this tool, you need to retreive
the file inside the bash terminal from the web dyno where it was uploaded.

Using `curl`
```bash
curl https://my-heroku-app.herokuapp.com/my_uploaded_file.csv -o my_uploaded_file.csv
```

Using `wget`
```bash
wget https://my-heroku-app.herokuapp.com/my_uploaded_file.csv my_uploaded_file.csv
```
