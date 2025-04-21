---
layout: page
title: "test city"
suburb: "test city"
---
  
This is an index page for **test city** in the `suburb` collection.

<ul>
    {% assign key = "suburb" %}
    {% assign value = page[key] %}

    {% for post in site.posts %}
        {% if post[key] == value %}
            <li><a href="{{ post.url }}">{{ post.title }}</a></li>
        {% endif %}
    {% endfor %}
</ul>
