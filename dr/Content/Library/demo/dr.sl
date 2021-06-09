namespace: demo
flow:
  name: dr
  workflow:
    - take_ownership_of_DR_event:
        do:
          demo.substring:
            - origin_string: x
        navigate:
          - SUCCESS: check_trouble_ticket_approval
          - FAILURE: notify_on_call
    - check_trouble_ticket_approval:
        do:
          io.cloudslang.base.utils.is_true:
            - bool_value: '1'
        navigate:
          - 'TRUE': network_check
          - 'FALSE': email_approver
    - email_approver:
        do:
          demo.substring:
            - origin_string: x
        navigate:
          - SUCCESS: waiting_for_approval
          - FAILURE: no_action_taken_pending_approval
    - waiting_for_approval:
        do:
          demo.flow: []
        navigate:
          - SUCCESS: no_action_taken_pending_approval
    - network_check:
        do:
          demo.ssh_flow:
            - host: x
            - command: x
            - username: 'y'
        navigate:
          - SUCCESS: destination_exchange_server_health_check
          - FAILURE: diagnosed_network_issue
    - notify_on_call:
        do:
          demo.flow: []
        navigate:
          - SUCCESS: no_action_taken_escalated
    - destination_exchange_server_health_check:
        do:
          demo.ssh_flow:
            - host: x
            - command: x
            - username: 'y'
        navigate:
          - SUCCESS: compare_source_and_destination_configs
          - FAILURE: no_action_taken_escalated
    - remove_from_exchange_cluster:
        do:
          demo.substring:
            - origin_string: x
        navigate:
          - SUCCESS: disable_monitoring
          - FAILURE: notify_SA_group
    - notify_SA_group:
        do:
          demo.ssh_flow:
            - host: x
            - command: x
            - username: 'y'
        navigate:
          - SUCCESS: disable_monitoring
          - FAILURE: on_failure
    - disable_monitoring:
        do:
          demo.flow_1: []
        navigate:
          - SUCCESS: failover_from_source_to_destination
          - FAILURE: on_failure
          - CUSTOM: failover_from_source_to_destination
    - failover_from_source_to_destination:
        do:
          demo.ssh_flow:
            - host: x
            - command: x
            - username: 'y'
        navigate:
          - SUCCESS: validate_destination_availability
          - FAILURE: on_failure
    - validate_destination_availability:
        do:
          demo.ssh_flow:
            - host: x
            - command: x
            - username: 'y'
        navigate:
          - SUCCESS: update_ticket
          - FAILURE: on_failure
    - update_ticket:
        do:
          demo.ssh_flow:
            - host: x
            - command: x
            - username: 'y'
        navigate:
          - SUCCESS: update_CMDB
          - FAILURE: notify_SA_group_on_ticket_updated
    - notify_SA_group_on_ticket_updated:
        do:
          demo.ssh_flow:
            - host: x
            - command: x
            - username: 'y'
        navigate:
          - SUCCESS: enable_monitoring
          - FAILURE: update_CMDB
    - update_CMDB:
        do:
          demo.substring:
            - origin_string: x
        navigate:
          - SUCCESS: enable_monitoring
          - FAILURE: on_failure
    - enable_monitoring:
        do:
          demo.flow_1: []
        navigate:
          - SUCCESS: add_to_exchange_cluster
          - FAILURE: on_failure
          - CUSTOM: add_to_exchange_cluster
    - add_to_exchange_cluster:
        do:
          demo.substring:
            - origin_string: x
        navigate:
          - SUCCESS: notify_SA_group_2
          - FAILURE: notify_on_call_1
    - clone_destination_server:
        do:
          demo.substring:
            - origin_string: x
        navigate:
          - SUCCESS: remove_from_exchange_cluster
          - FAILURE: on_failure
    - compare_source_and_destination_configs:
        do:
          demo.substring:
            - origin_string: x
        navigate:
          - SUCCESS: remove_from_exchange_cluster
          - FAILURE: clone_destination_server
    - notify_on_call_1:
        do:
          demo.flow: []
        navigate:
          - SUCCESS: SUCCESS
    - aknowledge_DR_event:
        do:
          demo.substring:
            - origin_string: x
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
    - notify_SA_group_2:
        do:
          demo.ssh_flow:
            - host: x
            - command: x
            - username: 'y'
        navigate:
          - SUCCESS: aknowledge_DR_event
          - FAILURE: on_failure
  results:
    - no_action_taken_pending_approval
    - diagnosed_network_issue
    - FAILURE
    - SUCCESS
    - no_action_taken_escalated
extensions:
  graph:
    steps:
      update_ticket:
        x: 1160
        'y': 920
        navigate:
          4a077c8f-b943-1280-e570-d5981c9b0888:
            vertices:
              - x: 1000
                'y': 960
            targetId: update_CMDB
            port: SUCCESS
      add_to_exchange_cluster:
        x: 480
        'y': 920
      enable_monitoring:
        x: 640
        'y': 920
      notify_SA_group:
        x: 680
        'y': 520
      failover_from_source_to_destination:
        x: 1160
        'y': 520
        navigate:
          9db51c62-a3f1-b9ad-ff74-b38c37bc0dfe:
            vertices:
              - x: 1280
                'y': 640
            targetId: validate_destination_availability
            port: SUCCESS
      email_approver:
        x: 480
        'y': 120
        navigate:
          370c78b0-08d3-7c7a-c7b4-877530e47d76:
            targetId: b82ef243-af97-9920-67f1-449ff9292e51
            port: FAILURE
            vertices:
              - x: 680
                'y': 80
              - x: 760
                'y': 80
      notify_on_call:
        x: 320
        'y': 320
        navigate:
          81e7d193-2d57-4492-5277-f9e2f8c52d04:
            targetId: f7d0b9d2-4bef-2722-cd51-f4920c9c9aec
            port: SUCCESS
      take_ownership_of_DR_event:
        x: 80
        'y': 120
      aknowledge_DR_event:
        x: 80
        'y': 920
        navigate:
          a533c42a-abe6-ae0f-1b6d-00ae78c1d0da:
            targetId: 9cf62e0b-7e0e-20ba-9189-26bd9d37bc1a
            port: SUCCESS
      waiting_for_approval:
        x: 680
        'y': 120
        navigate:
          9f05ae64-af66-610a-b21f-9efe2e866034:
            targetId: b82ef243-af97-9920-67f1-449ff9292e51
            port: SUCCESS
      notify_SA_group_on_ticket_updated:
        x: 960
        'y': 1000
        navigate:
          eb0af951-b13b-9b44-538d-2cc03c3a07df:
            vertices:
              - x: 880
                'y': 1080
              - x: 800
                'y': 1080
            targetId: enable_monitoring
            port: SUCCESS
      compare_source_and_destination_configs:
        x: 400
        'y': 720
      validate_destination_availability:
        x: 1160
        'y': 720
        navigate:
          437441b7-56b1-ce29-c457-3134e843473d:
            vertices:
              - x: 1280
                'y': 880
            targetId: update_ticket
            port: SUCCESS
      clone_destination_server:
        x: 600
        'y': 720
      destination_exchange_server_health_check:
        x: 320
        'y': 520
        navigate:
          3ab23e9a-a1c6-8e28-2a2e-60e8650fe9b7:
            vertices:
              - x: 440
                'y': 640
            targetId: compare_source_and_destination_configs
            port: SUCCESS
          0d71f03a-80df-5c03-4e68-604ae499467a:
            targetId: f7d0b9d2-4bef-2722-cd51-f4920c9c9aec
            port: FAILURE
      notify_SA_group_2:
        x: 280
        'y': 920
      check_trouble_ticket_approval:
        x: 320
        'y': 120
      network_check:
        x: 480
        'y': 320
        navigate:
          f1e35412-947b-79f0-058b-c6e12606cc04:
            targetId: fa610718-a2f8-6826-13da-414c5cf2e851
            port: FAILURE
      remove_from_exchange_cluster:
        x: 520
        'y': 520
        navigate:
          e33d90b0-fd67-98df-39c2-42687a3b0c8a:
            vertices:
              - x: 680
                'y': 480
              - x: 760
                'y': 480
            targetId: disable_monitoring
            port: SUCCESS
      notify_on_call_1:
        x: 160
        'y': 720
        navigate:
          3518ac5f-c661-925e-162d-a0aa1bcaf8d3:
            targetId: 9cf62e0b-7e0e-20ba-9189-26bd9d37bc1a
            port: SUCCESS
      update_CMDB:
        x: 800
        'y': 920
      disable_monitoring:
        x: 920
        'y': 520
    results:
      no_action_taken_pending_approval:
        b82ef243-af97-9920-67f1-449ff9292e51:
          x: 920
          'y': 120
      diagnosed_network_issue:
        fa610718-a2f8-6826-13da-414c5cf2e851:
          x: 920
          'y': 320
      SUCCESS:
        9cf62e0b-7e0e-20ba-9189-26bd9d37bc1a:
          x: 80
          'y': 560
      no_action_taken_escalated:
        f7d0b9d2-4bef-2722-cd51-f4920c9c9aec:
          x: 80
          'y': 320
