Function Gather-all-cluster-shrVolumes {

[CmdletBinding(SupportsShouldProcess=$true)]
    Param(
    [string]$ClusterName
    )

    Get-ClusterSharedVolume -Cluster $ClusterName | `
    Select-Object Name, `
                 @{Label = 'Path';expression={$_.FriendlyVolumeName}}, `
                 @{Label = 'Size(GB)';expression={$_.Partition.Size/1gb -as [int]}}, `
                 @{Label = 'Free Space(GB)';expression={$_.Partition.FreeSpace/1gb -as [int]}}, `
                 @{Label = 'Percentage Free(%)';expression={$_.Partition.PercentFree}} | `
    Export-Csv -Path "C:\$($ClusterName)-Clustervolumes.csv" -NoTypeInformation
            
}
