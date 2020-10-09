Describe "Azure Sentinel Hunting rules Tests" {

    $TestFiles = Get-ChildItem -Path .\SettingFiles\HuntingRules.json -File -Recurse | ForEach-Object -Process {
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
            'query',
            'tactics'
        )

        $rules = $ConvertedJson.Scheduled

        $rules.ForEach{
            $expected_elements | Should -BeIn $_.psobject.Properties.Name
        }
    }
}
