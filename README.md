# Vagrant + Docker + Apache Tomcat + JSP

This article describes how to deploy a JSP website using Docker, Apache Tomcat.

## Directory structure

I found a way to make a minimal JSP web application from scratch, without any IDE.
(ref: https://www.youtube.com/watch?v=JEBR_KJdzSk)

First, organize your working directory like this:

```
yourproject/
    Dockerfile
    install-docker.sh
    install-docker-compose.sh
    README.md
    run.sh
    Vagrantfile
    webapp/
        WEB-INF/
          classes/
          lib/
          web.xml
        index.jsp
```

Right now, just leave every folders and files empty.
This is the skeleton of our Dockerized web application.

## Web application

First, we should fill some content for our web application.
Take your favorite editor and edit these files:

### `yourproject/webapp/WEB-INF/web.xml`

```xml
<web-app>
</web-app>
```

It can be empty. Later, you can edit this file as you want.

### `yourproject/webapp/index.jsp`

```jsp
<!doctype html>
<h1>It works!</h1>
<%
  for (int i = 0; i < 5; ++i) {
      out.println("<p>Hello, world!</p>");
  }
%>
```

This is just an example; it will produce:

```html
<h1>It works!</h1>
<p>Hello, world!</p><p>Hello, world!</p><p>Hello, world!</p><p>Hello, world!</p><p>Hello, world!</p>
```

And that's all for our website. Not too complicated, right?

## Dockerfile

And let's make our `Dockerfile`. Open `yourproject/Dockerfile` and copy&paste these:

```dockerfile
FROM tomcat:9.0.1-jre8-alpine

ADD ./webapp /usr/local/tomcat/webapps/webapp

CMD ["catalina.sh", "run"]
```

That's everything we need. Let me explain each line:

### Apache Tomcat Image

```dockerfile
FROM tomcat:9.0.1-jre8-alpine
```

We use official `tomcat:9.0.1-jre8-alpine` image for our base image.
You can choose any other images you want, like `tomcat:8.5.23-jre8`.
But `tomcat:9.0.1-jre8-alpine` is the latest release of Apache Tomcat image on Docker Hub now
and has much smaller(~113MB) size than `tomcat:9.0.1-jre8`(~557MB) so I'll stick to use it.

### Copying Website and Start up Tomcat

```dockerfile
ADD ./webapp /usr/local/tomcat/webapps/webapp
```

The `ADD` instruction copies our local files(in our case, `yourproject/webapp` folder)
to container's file system(`/usr/local/tomcat/webapps/webapp`).
I tried to use a WAR file instead of plain source codes, but it didn't work for me for some reason.
If someone knows how to pre-compile all the JSP files and copy it into image, please leave a comment.

```dockerfile
CMD ["catalina.sh", "run"]
```

Finally, the `CMD` instruction will start up Apache Tomcat, which runs our web application.

## Build Docker Image and Run without Vagrant

Go to `yourproject/` in terminal, and type it to build a Docker image:

```bash
$ docker build -t mywebapp .
```

And then run:

```bash
$ docker run --rm -it -p 8888:8080 mywebapp
```

## Build Docker Image and Run with Vagrant

Go to `yourproject/` in terminal, and type it to build a Docker image:

```bash
$ vagrant up
```
And then run:

```bash
$ vagrant status
```

Visit `http://localhost:8888/webapp` to see if your website is running!