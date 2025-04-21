---
layout: page
title: "Northland"
region: "Northland"
---
  
This is an index page for **Northland** in the `region` collection.

<ul>
    {% assign key = "region" %}
    {% assign value = page[key] %}

    {% for post in site.posts %}
        {% if post[key] == value %}
            <li><a href="{{ post.url }}">{{ post.title }}</a></li>
        {% endif %}
    {% endfor %}
</ul>
