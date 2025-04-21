---
layout: page
title: "reviews"
category: "reviews"
---
  
This is an index page for **reviews** in the `category` collection.

<ul>
    {% assign key = "category" %}
    {% assign value = page[key] %}

    {% for post in site.posts %}
        {% if post[key] == value %}
            <li><a href="{{ post.url }}">{{ post.title }}</a></li>
        {% endif %}
    {% endfor %}
</ul>
