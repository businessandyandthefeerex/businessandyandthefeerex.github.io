---
layout: page
title: "Rotorua"
suburb: "Rotorua"
---
  
This is an index page for **Rotorua** in the `suburb` collection.

<ul>
    {% assign key = "suburb" %}
    {% assign value = page[key] %}

    {% for post in site.posts %}
        {% if post[key] == value %}
            <li><a href="{{ post.url }}">{{ post.title }}</a></li>
        {% endif %}
    {% endfor %}
</ul>
