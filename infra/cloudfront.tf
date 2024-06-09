
locals {
  s3_origin_id = "brickshire-gl"
}

# main cloudfront

resource "aws_cloudfront_origin_access_control" "originacl" {
  name                              = "${local.s3_origin_id}-acl"
  description                       = "policy"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name              = aws_s3_bucket.www_bucket.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.originacl.id
    origin_id                = "${local.s3_origin_id}-www.${var.bucket_name}"
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "main cloud dist. for brickshiregolfleagues"
  default_root_object = "index.html"

  logging_config {
    include_cookies = false
    bucket          = "static-logs-jrg.s3.amazonaws.com"
    prefix          = "bgl"
  }

  aliases = ["www.${var.domain_name}", var.domain_name]

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "${local.s3_origin_id}-www.${var.bucket_name}"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 31536000
    default_ttl            = 31536000
    max_ttl                = 31536000
    compress               = true
  }

  price_class = "PriceClass_200"

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CA", "GB", "DE"]
    }
  }

  tags = var.common_tags

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate_validation.cert_validation.certificate_arn
    ssl_support_method  = "sni-only"
  }
}


