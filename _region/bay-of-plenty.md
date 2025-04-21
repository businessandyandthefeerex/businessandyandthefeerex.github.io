---
layout: page
title: "Bay of Plenty"
region: "Bay of Plenty"
---
  
This is an index page for **Bay of Plenty** in the `region` collection.

<ul>
    {% assign key = "region" %}
    {% assign value = page[key] %}

    {% for post in site.posts %}
        {% if post[key] == value %}
            <li><a href="{{ post.url }}">{{ post.title }}</a></li>
        {% endif %}
    {% endfor %}
</ul>
