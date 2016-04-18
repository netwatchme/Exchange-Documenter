Get-AcceptedDomain     | export-clixml Get-AcceptedDomain.xml
Get-ActiveSyncDevice  | export-clixml Get-ActiveSyncDevice.xml
Get-ActiveSyncDevice | Get-ActiveSyncDeviceStatistics  | export-clixml Get-ActiveSyncDeviceStatistics.xml
Get-ActiveSyncMailboxPolicy  | export-clixml Get-ActiveSyncMailboxPolicy.xml
Get-ActiveSyncVirtualDirectory  | export-clixml Get-ActiveSyncVirtualDirectory.xml
Get-AddressList        | export-clixml Get-AddressList.xml
Get-AddressRewriteEntry | export-clixml Get-AddressRewriteEntry.xml
Get-AdServerSettings | export-clixml Get-AdServerSettings.xml
Get-ADSite             | export-clixml Get-ADSite.xml
Get-ADSiteLink         | export-clixml Get-ADSiteLink.xml
Get-AutodiscoverVirtualDirectory | export-clixml Get-AutodiscoverVirtualDirectory.xml
Get-AvailabilityAddressSpace | export-clixml Get-AvailabilityAddressSpace.xml
Get-CASMailbox | export-clixml Get-CASMailbox.xml
Get-ClientAccessServer | export-clixml Get-ClientAccessServer.xml
Get-ClientAccessArray  | export-clixml Get-ClientAccessArray.xml
Get-ClusteredMailboxServerStatus | export-clixml Get-ClusteredMailboxServerStatus.xml
Get-Contact            | export-clixml Get-Contact.xml
Get-DatabaseAvailabilityGroup | export-clixml Get-DatabaseAvailabilityGroup.xml
Get-DatabaseAvailabilityGroupNetwork | export-clixml Get-DatabaseAvailabilityGroupNetwork.xml
Get-DeliveryAgentConnector | export-clixml Get-DeliveryAgentConnector.xml
Get-DistributionGroup  | export-clixml Get-DistributionGroup.xml
Get-DynamicDistributionGroup | export-clixml Get-DynamicDistributionGroup.xml
Get-EcpVirtualDirectory | export-clixml Get-EcpVirtualDirectory.xml
Get-EdgeSubscription | export-clixml Get-EdgeSubscription.xml
Get-EmailAddressPolicy | export-clixml Get-EmailAddressPolicy.xml
Get-ExchangeServer     | export-clixml Get-ExchangeServer.xml
Get-ExchangeAdministrator | export-clixml Get-ExchangeAdministrator.xml
Get-ExchangeCertificate | export-clixml Get-ExchangeCertificate.xml
Get-ForeignConnector   | export-clixml Get-ForeignConnector.xml
Get-GlobalAddressList  | export-clixml Get-GlobalAddressList.xml
Get-IMAPSettings | export-clixml Get-IMAPSettings.xml
Get-JournalRule | export-clixml Get-JournalRule.xml
Get-MailboxServer | ForEach-Object { Get-LogonStatistics -server $_.name | export-clixml Get-LogonStatistics-$_.name.xml }
Get-Mailbox            | export-clixml Get-Mailbox.xml
Get-MailboxDatabase    | export-clixml Get-MailboxDatabase.xml
Get-MailboxDatabaseCopyStatus | export-clixml Get-MailboxDatabaseCopyStatus.xml
Get-Mailbox | Get-MailboxFolderStatistics | export-clixml Get-MailboxFolderStatistics.xml
Get-Mailbox | Get-MailboxPermission  | export-clixml Get-MailboxPermission.xml
Get-MailboxServer      | export-clixml Get-MailboxServer.xml
Get-MailboxServer | ForEach-Object { Get-MailboxStatistics -server $_.name | export-clixml Get-MailboxStatistics-$_.name.xml }
Get-MailPublicFolder   | export-clixml Get-MailPublicFolder.xml
Get-ManagementRole | export-clixml Get-ManagementRole.xml
Get-ManagementRoleAssignment | export-clixml Get-ManagementRoleAssignment.xml
Get-ManagementRoleEntry | export-clixml Get-ManagementRoleEntry.xml
Get-ManagementScope | export-clixml Get-ManagementScope.xml
Get-NetworkConnectionInfo | export-clixml Get-NetworkConnectionInfo.xml
Get-OABVirtualDirectory | export-clixml Get-OABVirtualDirectory.xml
Get-OfflineAddressBook | export-clixml Get-OfflineAddressBook.xml
Get-OrganizationConfig | export-clixml Get-OrganizationConfig.xml
Get-OutlookAnywhere | export-clixml Get-OutlookAnywhere.xml
Get-OutlookProtectionRule | export-clixml Get-OutlookProtectionRule.xml
Get-OwaMailboxPolicy    | export-clixml Get-OwaMailboxPolicy.xml
Get-OwaVirtualDirectory | export-clixml Get-OwaVirtualDirectory.xml
Get-POPSettings | export-clixml Get-POPSettings.xml
Get-PublicFolder -recurse | export-clixml Get-PublicFolder.xml
Get-PublicFolderAdministrativePermission - recurse | export-clixml Get-PublicFolderAdministrativePermissions.xml
Get-PublicFolderDatabase | export-clixml Get-PublicFolderDatabase.xml
Get-PublicFolderDatabase | ForEach-Object { Get-PublicFolderStatistics -server $_.ServerName | export-clixml Get-PublicFolderStatistics-$_.Servername.xml }
Get-ReceiveConnector   | export-clixml Get-ReceiveConnector.xml
Get-RemoteDomain       | export-clixml Get-RemoteDomain.xml
Get-RetentionPolicy | export-clixml Get-RetentionPolicy.xml
Get-RoleAssignmentPolicy | export-clixml Get-RoleAssignmentPolicy.xml
Get-RoleGroup | export-clixml Get-RoleGroup.xml
Get-RoleGroup | Get-RoleGroupMember | export-clixml Get-RoleGroupMember.xml
Get-RoutingGroupConnector | export-clixml Get-RoutingGroupConnector.xml
Get-RpcClientAccess | export-clixml Get-RpcClientAccess.xml
Get-SendConnector      | export-clixml Get-SendConnector.xml
Get-SharingPolicy      | export-clixml Get-SharingPolicy.xml
Get-StorageGroup      | export-clixml Get-StorageGroups.xml
Get-StorageGroup | Get-StorageGroupCopyStatus | export-clixml Get-StorageGroupCopyStatus.xml
Get-MailboxDatabase | Get-StoreUsageStatistics | export-clixml Get-StoreUsageStatistics.xml
Get-TransportAgent | export-clixml Get-TransportAgent.xml
Get-TransportConfig | export-clixml Get-TransportConfig.xml
Get-TransportPipeline | export-clixml Get-TransportPipeline.xml
Get-TransportRule | export-clixml Get-TransportRule.xml
Get-TransportServer | export-clixml Get-TransportServer.xml
Get-TextMessagingAccount | export-clixml Get-TextMessagingAccount.xml
Get-ThrottlingPolicy | export-clixml Get-ThrottlingPolicy.xml
Get-ThrottlingPolicyAssociation | export-clixml Get-ThrottlingPolicyAssociation.xml
Get-TransportAgent     | export-clixml Get-TransportAgent.xml
Get-TransportServer    | export-clixml Get-TransportServer.xml
Get-TransportServer | Get-Queue | export-clixml Get-Queue.xml
Get-WebServicesVirtualDirectory | export-clixml Get-WebServicesVirtualDirectory.xml
Get-X400AuthoritativeDomain | export-clixml Get-X400AuthoritativeDomain.xml


.\HardwareInventory.ps1
$count = 0
$ID2 = 83428239
$Servers = Get-ExchangeServer
$GetHardware = @()
$Servers | sort-object Name | %{
  $count += 1
  $pct = [math]::truncate($count/$Servers.count * 100)
  write-progress -ID $ID2 -activity "Hardware Inventory" -status $_.Name -percentcomplete $pct
  $GetHardware += $_.name | get-HardwareInventory
}
$GetHardware | export-clixml Get-Hardware.xml
