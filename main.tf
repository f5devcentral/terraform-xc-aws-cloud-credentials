locals {
  create_iam_user = var.aws_access_key == null || var.aws_secret_key == null
  access_key      = local.create_iam_user ? aws_iam_access_key.this[0].id : var.aws_access_key
  secret_key      = local.create_iam_user ? aws_iam_access_key.this[0].secret : var.aws_secret_key
}

resource "aws_iam_user" "this" {
  count = local.create_iam_user ? 1 : 0

  name = var.name
  tags = var.tags
}

resource "aws_iam_access_key" "this" {
  count = local.create_iam_user ? 1 : 0

  user = aws_iam_user.this[0].name
}

resource "aws_iam_policy" "tgw_site" {
  count = local.create_iam_user && var.create_aws_tgw_iam ? 1 : 0

  name        = "${var.name}-tgw-site-policy"
  description = "F5 XC Cloud AWS TGW Site policy"
  policy      = data.aws_iam_policy_document.tgw_site.json

  tags = var.tags
}

resource "aws_iam_user_policy_attachment" "tgw_site" {
  count = local.create_iam_user && var.create_aws_tgw_iam ? 1 : 0

  user       = aws_iam_user.this[0].name
  policy_arn = aws_iam_policy.tgw_site[0].arn
}

data "aws_iam_policy_document" "tgw_site" {
  version = "2012-10-17"
  statement {
    sid    = "EC2TGWPermissions"
    effect = "Allow"
    actions = [
      "ec2:AcceptTransitGatewayVpcAttachment",
      "ec2:AssociateTransitGatewayRouteTable",
      "ec2:CreateTransitGateway",
      "ec2:CreateTransitGatewayConnect",
      "ec2:CreateTransitGatewayConnectPeer",
      "ec2:CreateTransitGatewayPeeringAttachment",
      "ec2:CreateTransitGatewayPolicyTable",
      "ec2:CreateTransitGatewayPrefixListReference",
      "ec2:CreateTransitGatewayRoute",
      "ec2:CreateTransitGatewayRouteTable",
      "ec2:CreateTransitGatewayRouteTableAnnouncement",
      "ec2:CreateTransitGatewayVpcAttachment",
      "ec2:DeleteTransitGateway",
      "ec2:DeleteTransitGatewayRoute",
      "ec2:DeleteTransitGatewayRouteTable",
      "ec2:DeleteTransitGatewayVpcAttachment",
      "ec2:DescribeTransitGatewayAttachments",
      "ec2:DescribeTransitGatewayPeeringAttachments",
      "ec2:DescribeTransitGatewayRouteTables",
      "ec2:DescribeTransitGatewayVpcAttachments",
      "ec2:DescribeTransitGateways",
      "ec2:DisableTransitGatewayRouteTablePropagation",
      "ec2:DisassociateTransitGatewayRouteTable",
      "ec2:EnableTransitGatewayRouteTablePropagation",
      "ec2:GetTransitGatewayRouteTableAssociations",
      "ec2:GetTransitGatewayRouteTablePropagations",
      "ec2:ModifyTransitGateway",
      "ec2:ModifyTransitGatewayVpcAttachment",
      "ec2:SearchTransitGatewayRoutes"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "directconnect" {
  count = local.create_iam_user && var.create_direct_connect_iam ? 1 : 0

  name        = "${var.name}-directconnect-policy"
  description = "F5 XC Cloud AWS DirectConnect policy"
  policy      = data.aws_iam_policy_document.directconnect.json

  tags = var.tags
}

resource "aws_iam_user_policy_attachment" "directconnect" {
  count = local.create_iam_user && var.create_direct_connect_iam ? 1 : 0

  user       = aws_iam_user.this[0].name
  policy_arn = aws_iam_policy.directconnect[0].arn
}

data "aws_iam_policy_document" "directconnect" {
  version = "2012-10-17"
  statement {
    sid    = "DirectConnectPermissions"
    effect = "Allow"
    actions = [
      "directconnect:AllocateHostedConnection",
      "directconnect:AllocatePrivateVirtualInterface",
      "directconnect:AllocatePublicVirtualInterface",
      "directconnect:AssociateHostedConnection",
      "directconnect:AssociateVirtualInterface",
      "directconnect:ConfirmConnection",
      "directconnect:ConfirmPrivateVirtualInterface",
      "directconnect:ConfirmPublicVirtualInterface",
      "directconnect:CreateConnection",
      "directconnect:CreateDirectConnectGateway",
      "directconnect:CreateDirectConnectGatewayAssociation",
      "directconnect:CreatePrivateVirtualInterface",
      "directconnect:CreatePublicVirtualInterface",
      "directconnect:DeleteConnection",
      "directconnect:DeleteDirectConnectGateway",
      "directconnect:DeleteDirectConnectGatewayAssociation",
      "directconnect:DeleteVirtualInterface",
      "directconnect:DescribeConnections",
      "directconnect:DescribeDirectConnectGatewayAssociations",
      "directconnect:DescribeDirectConnectGatewayAttachments",
      "directconnect:DescribeDirectConnectGateways",
      "directconnect:DescribeHostedConnections",
      "directconnect:DescribeTags",
      "directconnect:DescribeVirtualGateways",
      "directconnect:DescribeVirtualInterfaces",
      "directconnect:TagResource",
      "directconnect:UntagResource",
      "directconnect:UpdateConnection",
      "directconnect:UpdateDirectConnectGatewayAssociation"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_user_policy_attachment" "vpc_site" {
  count = local.create_iam_user ? 1 : 0

  user       = aws_iam_user.this[0].name
  policy_arn = aws_iam_policy.vpc_site[0].arn
}

resource "aws_iam_policy" "vpc_site" {
  count = local.create_iam_user ? 1 : 0

  name        = "${var.name}-vpc-site-policy"
  description = "F5 XC Cloud AWS VPC Site policy"
  policy      = data.aws_iam_policy_document.vpc_site.json

  tags = var.tags
}

data "aws_iam_policy_document" "vpc_site" {
  version = "2012-10-17"
  statement {
    sid    = "AutoScalingPermissions"
    effect = "Allow"
    actions = [
      "autoscaling:AttachLoadBalancerTargetGroups",
      "autoscaling:AttachLoadBalancers",
      "autoscaling:CreateAutoScalingGroup",
      "autoscaling:CreateLaunchConfiguration",
      "autoscaling:DeleteAutoScalingGroup",
      "autoscaling:DeleteLaunchConfiguration",
      "autoscaling:DescribeAutoScalingGroups",
      "autoscaling:DescribeLaunchConfigurations",
      "autoscaling:DescribeLoadBalancerTargetGroups",
      "autoscaling:DescribeLoadBalancers",
      "autoscaling:DescribeScalingActivities",
      "autoscaling:DescribeTags",
      "autoscaling:DetachLoadBalancerTargetGroups",
      "autoscaling:DetachLoadBalancers",
      "autoscaling:DisableMetricsCollection",
      "autoscaling:EnableMetricsCollection",
      "autoscaling:ResumeProcesses",
      "autoscaling:SuspendProcesses",
      "autoscaling:UpdateAutoScalingGroup"
    ]
    resources = ["*"]
  }
  statement {
    sid    = "EC2Permissions"
    effect = "Allow"
    actions = [
      "ec2:AllocateAddress",
      "ec2:AssignPrivateIpAddresses",
      "ec2:AssociateAddress",
      "ec2:AssociateIamInstanceProfile",
      "ec2:AssociateRouteTable",
      "ec2:AssociateSubnetCidrBlock",
      "ec2:AssociateVpcCidrBlock",
      "ec2:AttachInternetGateway",
      "ec2:AttachNetworkInterface",
      "ec2:AttachVpnGateway",
      "ec2:AuthorizeSecurityGroupEgress",
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:CreateCustomerGateway",
      "ec2:CreateInternetGateway",
      "ec2:CreateNetworkInterface",
      "ec2:CreateRoute",
      "ec2:CreateRouteTable",
      "ec2:CreateSecurityGroup",
      "ec2:CreateSubnet",
      "ec2:CreateTags",
      "ec2:CreateVpc",
      "ec2:CreateVpnConnection",
      "ec2:CreateVpnConnectionRoute",
      "ec2:CreateVpnGateway",
      "ec2:DeleteClientVpnEndpoint",
      "ec2:DeleteClientVpnRoute",
      "ec2:DeleteCustomerGateway",
      "ec2:DeleteInternetGateway",
      "ec2:DeleteNetworkInterface",
      "ec2:DeleteRoute",
      "ec2:DeleteRouteTable",
      "ec2:DeleteSecurityGroup",
      "ec2:DeleteSubnet",
      "ec2:DeleteTags",
      "ec2:DeleteVpc",
      "ec2:DeleteVpnConnection",
      "ec2:DeleteVpnGateway",
      "ec2:DescribeAccountAttributes",
      "ec2:DescribeAddresses",
      "ec2:DescribeAddressesAttribute",
      "ec2:DescribeClientVpnConnections",
      "ec2:DescribeClientVpnEndpoints",
      "ec2:DescribeCustomerGateways",
      "ec2:DescribeIamInstanceProfileAssociations",
      "ec2:DescribeImages",
      "ec2:DescribeInstanceAttribute",
      "ec2:DescribeInstanceCreditSpecifications",
      "ec2:DescribeInstanceTypes",
      "ec2:DescribeInstances",
      "ec2:DescribeInternetGateways",
      "ec2:DescribeNetworkAcls",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DescribeRouteTables",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeSecurityGroupRules",
      "ec2:DescribeSubnets",
      "ec2:DescribeTags",
      "ec2:DescribeVolumes",
      "ec2:DescribeVolumesModifications",
      "ec2:DescribeVpcAttribute",
      "ec2:DescribeVpcClassicLink",
      "ec2:DescribeVpcClassicLinkDnsSupport",
      "ec2:DescribeVpcs",
      "ec2:DescribeVpnConnections",
      "ec2:DescribeVpnGateways",
      "ec2:DetachInternetGateway",
      "ec2:DetachNetworkInterface",
      "ec2:DetachVpnGateway",
      "ec2:DisableVgwRoutePropagation",
      "ec2:DisassociateAddress",
      "ec2:DisassociateIamInstanceProfile",
      "ec2:DisassociateRouteTable",
      "ec2:DisassociateSubnetCidrBlock",
      "ec2:DisassociateVpcCidrBlock",
      "ec2:EnableVgwRoutePropagation",
      "ec2:GetPasswordData",
      "ec2:ModifyInstanceAttribute",
      "ec2:ModifyInstanceCreditSpecification",
      "ec2:ModifyInstanceMetadataOptions",
      "ec2:ModifyNetworkInterfaceAttribute",
      "ec2:ModifySubnetAttribute",
      "ec2:ModifyVolume",
      "ec2:ModifyVpcAttribute",
      "ec2:ModifyVpnConnection",
      "ec2:ModifyVpnConnectionOptions",
      "ec2:MonitorInstances",
      "ec2:ReleaseAddress",
      "ec2:ReplaceIamInstanceProfileAssociation",
      "ec2:ReplaceRoute",
      "ec2:ReplaceRouteTableAssociation",
      "ec2:RevokeSecurityGroupEgress",
      "ec2:RevokeSecurityGroupIngress",
      "ec2:RunInstances",
      "ec2:StartInstances",
      "ec2:StopInstances",
      "ec2:TerminateInstances",
      "ec2:UnassignPrivateIpAddresses",
      "ec2:UnmonitorInstances",
      "ec2:DescribeRegions",
      "ec2:DescribeAvailabilityZones",
      "ec2:DescribeInstanceTypeOfferings",
      "ec2:CreateLaunchTemplate",
      "ec2:CreateLaunchTemplateVersion",
      "ec2:DescribeLaunchTemplates",
      "ec2:DescribeLaunchTemplateVersions",
      "ec2:ModifyLaunchTemplate",
      "ec2:DeleteLaunchTemplate",
      "ec2:DeleteLaunchTemplateVersions"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "ELBPermissions"
    effect = "Allow"
    actions = [
      "elasticloadbalancing:AddTags",
      "elasticloadbalancing:CreateListener",
      "elasticloadbalancing:CreateLoadBalancer",
      "elasticloadbalancing:CreateTargetGroup",
      "elasticloadbalancing:DeleteListener",
      "elasticloadbalancing:DeleteLoadBalancer",
      "elasticloadbalancing:DeleteTargetGroup",
      "elasticloadbalancing:DeregisterTargets",
      "elasticloadbalancing:DescribeInstanceHealth",
      "elasticloadbalancing:DescribeListeners",
      "elasticloadbalancing:DescribeListenerAttributes",
      "elasticloadbalancing:DescribeLoadBalancerAttributes",
      "elasticloadbalancing:DescribeLoadBalancers",
      "elasticloadbalancing:DescribeTags",
      "elasticloadbalancing:DescribeTargetGroupAttributes",
      "elasticloadbalancing:DescribeTargetGroups",
      "elasticloadbalancing:DescribeTargetHealth",
      "elasticloadbalancing:ModifyListener",
      "elasticloadbalancing:ModifyLoadBalancerAttributes",
      "elasticloadbalancing:ModifyTargetGroup",
      "elasticloadbalancing:ModifyTargetGroupAttributes",
      "elasticloadbalancing:RegisterTargets",
      "elasticloadbalancing:RemoveTags"
    ]
    resources = ["*"]
  }
  statement {
    sid    = "IAMPermissions"
    effect = "Allow"
    actions = [
      "iam:AddRoleToInstanceProfile",
      "iam:AttachRolePolicy",
      "iam:CreateInstanceProfile",
      "iam:CreatePolicy",
      "iam:CreatePolicyVersion",
      "iam:CreateRole",
      "iam:CreateServiceLinkedRole",
      "iam:DeleteInstanceProfile",
      "iam:DeletePolicy",
      "iam:DeletePolicyVersion",
      "iam:DeleteRole",
      "iam:DeleteRolePermissionsBoundary",
      "iam:DeleteRolePolicy",
      "iam:DetachRolePolicy",
      "iam:GetInstanceProfile",
      "iam:GetPolicy",
      "iam:GetPolicyVersion",
      "iam:GetRole",
      "iam:ListAttachedRolePolicies",
      "iam:ListInstanceProfilesForRole",
      "iam:ListPolicyVersions",
      "iam:ListRolePolicies",
      "iam:PassRole",
      "iam:PutRolePermissionsBoundary",
      "iam:RemoveRoleFromInstanceProfile",
      "iam:TagPolicy",
      "iam:TagInstanceProfile",
      "iam:TagRole",
      "iam:UpdateAssumeRolePolicy",
      "iam:UpdateRole",
      "iam:UpdateRoleDescription"
    ]
    resources = ["*"]
  }
}

resource "volterra_cloud_credentials" "this" {
  name      = var.name
  namespace = "system"
  aws_secret_key {
    access_key = local.access_key
    secret_key {
      clear_secret_info {
        url = "string:///${base64encode(local.secret_key)}"
      }
    }
  }
}
