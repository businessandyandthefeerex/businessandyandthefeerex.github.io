---
layout: page
title: "Kerikeri"
suburb: "Kerikeri"
---
  
This is an index page for **Kerikeri** in the `suburb` collection.

<ul>
    {% assign key = "suburb" %}
    {% assign value = page[key] %}

    {% for post in site.posts %}
        {% if post[key] == value %}
            <li><a href="{{ post.url }}">{{ post.title }}</a></li>
        {% endif %}
    {% endfor %}
</ul>
