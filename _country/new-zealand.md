---
layout: page
title: "New Zealand"
country: "New Zealand"
---
  
This is an index page for **New Zealand** in the `country` collection.

<ul>
    {% assign key = "country" %}
    {% assign value = page[key] %}

    {% for post in site.posts %}
        {% if post[key] == value %}
            <li><a href="{{ post.url }}">{{ post.title }}</a></li>
        {% endif %}
    {% endfor %}
</ul>
