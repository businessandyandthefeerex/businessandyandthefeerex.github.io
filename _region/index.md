---
layout: page
title: "Region Index"
permalink: /region/
---

This is the index page for the `region` collection.

<ul>
    {% assign all_values = site.region | sort: "title" %}
    {% for item in all_values %}
        {% unless item.url == page.url %}
            <li><a href="{{ item.url }}">{{ item.title }}</a></li>
        {% endunless %}
    {% endfor %}
</ul>
