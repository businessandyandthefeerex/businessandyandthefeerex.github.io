---
layout: page
title: "Australia"
country: "Australia"
---
  
This is an index page for **Australia** in the `country` collection.

<ul>
    {% assign key = "country" %}
    {% assign value = page[key] %}

    {% for post in site.posts %}
        {% if post[key] == value %}
            <li><a href="{{ post.url }}">{{ post.title }}</a></li>
        {% endif %}
    {% endfor %}
</ul>
