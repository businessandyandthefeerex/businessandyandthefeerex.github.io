---
layout: page
title: "Reviews from 20 May 2023"
permalink: /reviews/2023/05/20/
year: 2023
month: 05
day: 20
---
[↑ Go to May 2023](/reviews/2023/05/)

{% assign this_year = page.year | plus: 0 %}
{% assign this_month = page.month | plus: 0 %}
{% assign this_day = page.day | plus: 0 %}
<ul>
    {% for post in site.posts %}
        {% assign review_year = post.date | date: "%Y" | plus: 0 %}
        {% assign review_month = post.date | date: "%m" | plus: 0 %}
        {% assign review_day = post.date | date: "%d" | plus: 0 %}
        {% if review_year == this_year and review_month == this_month and review_day == this_day %}
            <li><a href="{{ post.url }}">{{ post.title }}</a></li>
        {% endif %}
    {% endfor %}
</ul>
