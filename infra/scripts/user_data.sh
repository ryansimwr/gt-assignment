#!/bin/bash
sudo dnf update 
sudo dnf install -y nginx 
sudo systemctl start nginx.service
sudo systemctl status nginx.service
sudo systemctl enable nginx.service
