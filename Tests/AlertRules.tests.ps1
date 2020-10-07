Describe "Azure Sentinel AlertRules Tests" {

    $TestFiles = Get-ChildItem -Path .\SettingFiles\AlertRules.json -File -Recurse | ForEach-Object -Process {
        @{
            File          = $_.FullName
            ConvertedJson = (Get-Content -Path $_.FullName | ConvertFrom-Json)
            Path          = $_.DirectoryName
            Name          = $_.Name
        }
    }

    It 'Converts from JSON | <File>' -TestCases $TestFiles {
        param (
            $File,
            $ConvertedJson
        )
        $ConvertedJson | Should -Not -Be $null
    }

    It 'Schedueled rules have the minimum elements' -TestCases $TestFiles {
        param (
            $File,
            $ConvertedJson
        )
        $expected_elements = @(
            'displayName',
            'description',
            'severity',
            'enabled',
            'query',
            'queryFrequency',
            'queryPeriod',
            'triggerOperator',
            'triggerThreshold',
            'suppressionDuration',
            'suppressionEnabled',
            'tactics',
            'playbookName'
        )

        $rules = $ConvertedJson.Scheduled

        $rules.ForEach{
            $expected_elements | Should -BeIn $_.psobject.Properties.Name
        }
    }

    It 'Fusion rules have the minimum elements' -TestCases $TestFiles {
        param (
            $File,
            $ConvertedJson
        )
        $expected_elements = @(
            'displayName',
            'enabled',
            'alertRuleTemplateName'
        )

        $rules = $ConvertedJson.Fusion

        $rules.ForEach{
            $expected_elements | Should -BeIn $_.psobject.Properties.Name
        }
    }

    It 'MLBehaviorAnalytics rules have the minimum elements' -TestCases $TestFiles {
        param (
            $File,
            $ConvertedJson
        )
        $expected_elements = @(
            'displayName',
            'enabled',
            'alertRuleTemplateName'
        )

        $rules = $ConvertedJson.MLBehaviorAnalytics

        $rules.ForEach{
            $expected_elements | Should -BeIn $_.psobject.Properties.Name
        }
    }

    It 'MicrosoftSecurityIncidentCreation rules have the minimum elements' -TestCases $TestFiles {
        param (
            $File,
            $ConvertedJson
        )
        $expected_elements = @(
            'displayName',
            'enabled',
            'description',
            'productFilter',
            'severitiesFilter',
            'displayNamesFilter'
        )

        $rules = $ConvertedJson.MicrosoftSecurityIncidentCreation

        $rules.ForEach{
            $expected_elements | Should -BeIn $_.psobject.Properties.Name
        }
    }
}
