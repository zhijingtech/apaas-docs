# ORY NetWork

ORY Kratos 是一个强大的身份和用户管理系统，但其设计初衷并不直接支持多租户架构。这意味着，如果你需要一个多租户的身份管理解决方案，ORY Network 是目前唯一支持这种设置的官方选项。ORY Network 通过其托管服务解决了这些问题，提供了一个可扩展的多租户环境。在这种设置中，开发者无需担心底层基础设施的复杂性和数据管理问题，而可以专注于构建和部署应用程序。

## 多租户

ORY Network 采用的是 workspace 来隔离项目，没有使用租户概念，更像根级目录。用户在不同的 workspace 之间切换，identity 不会变化，登录会话都是复用的。下面是 https://project.console.ory.sh/sessions/whoami 返回的信息：

```json
{
  "id": "33efe750-9ef1-489d-a293-aed61c386c48",
  "active": true,
  "expires_at": "2025-02-16T03:46:45.099116Z",
  "authenticated_at": "2025-01-17T03:46:45.099116Z",
  "authenticator_assurance_level": "aal1",
  "authentication_methods": [
    {
      "method": "oidc",
      "aal": "aal1",
      "completed_at": "2025-01-17T03:46:45.09903912Z",
      "provider": "github"
    }
  ],
  "issued_at": "2025-01-17T03:46:45.099116Z",
  "identity": {
    "id": "aaf5fad4-28ad-455c-aee4-4fd9d7b7bc83",
    "schema_id": "...",
    "schema_url": "...",
    "state": "active",
    "traits": {
      "consent": {
        "newsletter": false,
        "tos": "2024-11-22T09:13:34.324Z"
      },
      "details": {
        "company": "zj.tech",
        "currentSolution": "",
        "jobtitle": "Infrastructure Architect",
        "knowsFrom": "",
        "phone": "",
        "useCase": ""
      },
      "email": "***@foxmail.com",
      "name": "***"
    },
    "verifiable_addresses": [
      {
        "id": "f7aaf85d-bc58-4300-b07b-88044b9bb2a0",
        "value": "***@foxmail.com",
        "verified": false,
        "via": "email",
        "status": "sent",
        "created_at": "2024-11-22T09:13:38.344571Z",
        "updated_at": "2024-11-22T09:13:38.344571Z"
      }
    ],
    "recovery_addresses": [
      {
        "id": "4128d994-3dc3-41eb-8777-7628d3f5cbd0",
        "value": "***@foxmail.com",
        "via": "email",
        "created_at": "2024-11-22T09:13:38.582284Z",
        "updated_at": "2024-11-22T09:13:38.582284Z"
      }
    ],
    "metadata_public": {
      "github_username": "***"
    },
    "created_at": "2024-11-22T09:13:38.338052Z",
    "updated_at": "2024-11-22T09:15:33.479422Z",
    "organization_id": null
  },
  "devices": [
    {
      "id": "2688f6ae-0fd3-4c2e-85d3-9f9b79c3862d",
      "ip_address": "2401:c080:3800:290f:5400:4ff:fe7d:ddc",
      "user_agent": "...",
      "location": "Osaka, JP"
    }
  ]
}
```

我们在看一下认证信息，比对 cookie 中的 ory_session_ory 发现切换 workspace 后也没变化，基本上确认只用 workspace_id 和 project_id 隔离数据。
