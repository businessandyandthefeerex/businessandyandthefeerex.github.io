---
layout: page
title: "Country Index"
permalink: /country/
---

This is the index page for the `country` collection.

<ul>
    {% assign all_values = site.country | sort: "title" %}
    {% for item in all_values %}
        {% unless item.url == page.url %}
            <li><a href="{{ item.url }}">{{ item.title }}</a></li>
        {% endunless %}
    {% endfor %}
</ul>
