---
layout: page
title: "Reviews from 25 October 2022"
permalink: /reviews/2022/10/25/
year: 2022
month: 10
day: 25
---
[↑ Go to October 2022](/reviews/2022/10/)

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
