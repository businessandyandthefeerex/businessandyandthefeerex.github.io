---
layout: latest
permalink: /latest/
title: Our latest post
---

{% assign latest_post = site.posts | first %}

# [{{ latest_post.title }}]({{ latest_post.url }})

*{{ latest_post.date | date: "%B %-d, %Y" }}*

{{ latest_post.content }}