<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Email_new_Contact</fullName>
        <description>Email new Contact</description>
        <protected>false</protected>
        <recipients>
            <field>Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Welcome</template>
    </alerts>
    <rules>
        <fullName>WelcomeRule</fullName>
        <actions>
            <name>Email_new_Contact</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contacts__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Provider</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
