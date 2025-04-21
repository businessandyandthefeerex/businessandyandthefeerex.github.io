---
layout: page
title: "Wellington"
region: "Wellington"
---
  
This is an index page for **Wellington** in the `region` collection.

<ul>
    {% assign key = "region" %}
    {% assign value = page[key] %}

    {% for post in site.posts %}
        {% if post[key] == value %}
            <li><a href="{{ post.url }}">{{ post.title }}</a></li>
        {% endif %}
    {% endfor %}
</ul>
