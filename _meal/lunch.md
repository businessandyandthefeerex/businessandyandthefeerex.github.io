---
layout: page
title: "lunch"
meal: "lunch"
---
  
This is an index page for **lunch** in the `meal` collection.

<ul>
    {% assign key = "meal" %}
    {% assign value = page[key] %}

    {% for post in site.posts %}
        {% if post[key] == value %}
            <li><a href="{{ post.url }}">{{ post.title }}</a></li>
        {% endif %}
    {% endfor %}
</ul>
