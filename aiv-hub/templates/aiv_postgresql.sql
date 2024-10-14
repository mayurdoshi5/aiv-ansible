DROP TABLE IF EXISTS ai_embed cascade; 
DROP TABLE IF EXISTS ai_privilege cascade; 
DROP TABLE IF EXISTS ai_file_options cascade; 
DROP TABLE IF EXISTS ai_anot_privilege cascade; 
DROP TABLE IF EXISTS ai_lovrow_mapping cascade; 
DROP TABLE IF EXISTS ai_report_management cascade; 
DROP TABLE IF EXISTS ai_filefolder_output cascade; 
DROP TABLE IF EXISTS ai_alertSuccess cascade; 
DROP TABLE IF EXISTS ai_fileandfolder cascade; 
DROP TABLE IF EXISTS ai_category cascade; 
DROP TABLE IF EXISTS ai_privilege_template cascade; 
DROP TABLE IF EXISTS ai_user cascade; 
DROP TABLE IF EXISTS ai_event_request cascade; 
DROP TABLE IF EXISTS ai_event_mail cascade; 
DROP TABLE IF EXISTS ai_event cascade; 
DROP TABLE IF EXISTS ai_request_parameter cascade; 
DROP TABLE IF EXISTS ai_recurring_request cascade; 
DROP TABLE IF EXISTS ai_request_task cascade; 
DROP TABLE IF EXISTS ai_request cascade; 
DROP TABLE IF EXISTS ai_session cascade; 
DROP TABLE IF EXISTS ai_filetype cascade; 
DROP TABLE IF EXISTS ai_filetype_output cascade; 
DROP TABLE IF EXISTS ai_role cascade; 
DROP TABLE IF EXISTS ai_user_role cascade; 
DROP TABLE IF EXISTS ai_notification cascade; 
DROP TABLE IF EXISTS ai_parameter cascade; 
DROP TABLE IF EXISTS ai_quickrun_parameter cascade; 
DROP TABLE IF EXISTS ai_quickrun cascade; 
DROP TABLE IF EXISTS ai_ldap_user_role cascade; 
DROP TABLE IF EXISTS ai_audit cascade; 
DROP TABLE IF EXISTS ai_email_users cascade; 
DROP TABLE IF EXISTS ai_quicklink cascade; 
DROP TABLE IF EXISTS ai_dm cascade; 
DROP TABLE IF EXISTS ai_dm_detail cascade; 
DROP TABLE IF EXISTS ai_dm_applicable_area cascade; 
DROP TABLE IF EXISTS ai_dm_privilege cascade; 
DROP TABLE IF EXISTS ai_usertype_map cascade; 
DROP TABLE IF EXISTS ai_backupuser cascade; 
DROP TABLE IF EXISTS ai_im_comments cascade; 
DROP TABLE IF EXISTS ai_timezone cascade; 
DROP TABLE IF EXISTS ai_license cascade; 
DROP TABLE IF EXISTS ai_annotation cascade; 
DROP TABLE IF EXISTS ai_extdb_priv cascade; 
DROP TABLE IF EXISTS ai_external_db cascade; 
DROP TABLE IF EXISTS ai_department cascade; 
DROP TABLE IF EXISTS ai_datasource cascade; 
DROP TABLE IF EXISTS ai_datasource_type cascade; 
DROP TABLE IF EXISTS ai_time_scheduler_cron cascade; 
DROP TABLE IF EXISTS ai_file_output cascade; 
DROP EXTENSION IF EXISTS intarray cascade; 



CREATE TABLE ai_category
(
  id serial NOT NULL,
  category character varying(50),
  folderpath character varying(255),
  CONSTRAINT ai_category_category_key UNIQUE (category)
);


CREATE TABLE ai_embed (
 id serial NOT NULL,
 keyinfo character varying(1000) DEFAULT NULL,
 section character varying(45) DEFAULT NULL,
 filename character varying(255) DEFAULT NULL,
 fileid integer DEFAULT NULL,
 owner character varying(255) DEFAULT NULL,
 validity timestamp without time zone NULL DEFAULT NULL,
 bypass integer DEFAULT '0',
 token character varying(1000) DEFAULT NULL,
 department character varying(255) DEFAULT NULL,
 decryptionkey character varying(1000) DEFAULT NULL,
 CONSTRAINT ai_embed_pkey PRIMARY KEY (id)
);

CREATE TABLE ai_fileandfolder
(
  id serial NOT NULL,
  description character varying(255),
  owner character varying(255),
  rootfolder character varying(255),
  category character varying(255),
  path character varying(255),
  name character varying(255),
  type character varying(255),
  versionno integer,
  visibilitytype character varying(255),
  visible integer,
  createdby character varying(255),
  createdon timestamp without time zone,
  isdefault integer,
  lastupdatedon timestamp without time zone,
  lastupdatedby character varying(255),
  isarchivable integer DEFAULT 1,
  isarchived integer DEFAULT 0,
  ispurgeable integer DEFAULT 1,
  ispurged integer DEFAULT 0,
  CONSTRAINT ai_fileandfolder_pkey PRIMARY KEY (id)
);

CREATE TABLE ai_privilege
(
  id serial NOT NULL,
  fileid integer,
  privilegetype character varying(255),
  user_rolename character varying(255),
  privilegevalue character varying(255),
  canedit integer DEFAULT 0,
  CONSTRAINT ai_privilege_pkey PRIMARY KEY (id),
  CONSTRAINT ai_privilege_fileid_fkey FOREIGN KEY (fileid) REFERENCES public.ai_fileandfolder (id) ON DELETE CASCADE 
);

CREATE TABLE ai_file_options
(
    id serial NOT NULL,
    fileid integer,
    privilegetype character varying(255),
    user_rolename character varying(255),
	extra_info text DEFAULT '{}',
    CONSTRAINT ai_file_options_pkey PRIMARY KEY (id),
    CONSTRAINT ai_file_options_fileid_fkey FOREIGN KEY (fileid) REFERENCES public.ai_fileandfolder (id) ON DELETE CASCADE
);

CREATE TABLE ai_anot_privilege
(
  id serial NOT NULL,
  dashboard_id character varying(255),
  widget_id character varying(255),  
  user_role_name character varying(255),
  privilege_type character varying(255),
  owner character varying(255),
  privilege_value character varying(1) DEFAULT 0,
  CONSTRAINT ai_anot_privilege_pkey PRIMARY KEY (id)
);


CREATE TABLE ai_privilege_template
(
  id serial NOT NULL,
  privilegetype character varying(255),
  user_rolename character varying(255),
  status character varying(255),
  privilegevalue character varying(255),
  CONSTRAINT ai_privilege_template_pkey PRIMARY KEY (id)
);

CREATE TABLE ai_user
(
  id serial NOT NULL,
  firstname character varying(255),
  lastname character varying(255),
  username character varying(255),
  status character varying(255),
  password character varying(255),
  email character varying(255),
  homefolder character varying(255),
  backupuserid character varying(255),
  manageruserid character varying(255),
  dashboardoption character varying(1) default '0',
  alertsOption character varying(1) default '0',
  reportOption character varying(1) default '0',
  mergeReportOption character varying(1) default '0',
  adhocOption character varying(1) default '0',
  resourceOption character varying(1) default '0',
  quickRunOption character varying(1) default '0',
  mappingOption character varying(1) default '0',
  messageOption character varying(1) default '0',
  datasetOption character varying(1) default '0',
  parameterOption character varying(1) default '0',
  annotationOption character varying(1) default '0',
  notificationOption character varying(1) default '0',
  requestOption character varying(1) default '0',
  adminOption character varying(1) default '0',
  scheduleOption character varying(1) default '0',
  usertype character varying(255),
  default_dashboard character varying(255),
landing_page character varying(255),
locale character varying(255),
timezone character varying(255),
theme character varying(255),
notification character varying(1) default '0',
department character varying(255),
showname character varying(1) default '1',
showimage character varying(1) default '1',
  CONSTRAINT ai_user_pkey PRIMARY KEY (id),
  CONSTRAINT ai_user_username_key UNIQUE (username)
);

CREATE TABLE ai_session
(
 id serial NOT NULL,
  username character varying(255),
  starttime timestamp without time zone,
  expiretime timestamp without time zone,
  token character varying(255),
  additionalsecurity character varying(255),
  clientsource character varying(255),
  CONSTRAINT ai_session_pkey PRIMARY KEY (id)
);


CREATE TABLE ai_department (
id serial NOT NULL,
deptName character varying(255),
deptCode character varying(255)
);

CREATE TABLE ai_request
(
  id serial NOT NULL,
  groupid character varying(255) DEFAULT 0,
  onsuccessnextjobid integer DEFAULT 0,
  onfailnextjobid integer DEFAULT 0,
  frequency character varying(255),
  status character varying(255),
  priority timestamp without time zone DEFAULT now(),
  startdate timestamp without time zone,
  enddate timestamp without time zone,
  approvalrequired integer DEFAULT 0,
  groupapprovalrequired integer DEFAULT 0,
  username character varying(255),
  privilegetemplateid character varying(255) DEFAULT 0,
  reportstatus character varying(255),
  created_by character varying(255),
  created_on timestamp without time zone,
  last_updated_by character varying(255),
  last_updated_on timestamp without time zone,
  fileid character varying(255),
  output_path character varying(255),
  output_name character varying(255),
  output_format character varying(255),
  output_id integer,
  delivery_path character varying(255),
  email_address text,
  email_required character varying(1) default '0',
  email_tousers text,
  email_toroles text,
  email_cc text,
  email_required_cc character varying(1) default '0',
  email_cc_tousers text,
  email_cc_toroles text,
  email_bcc text,
  email_required_bcc character varying(1) default '0',
  email_bcc_tousers text,
  email_bcc_toroles text,
  exportReport character varying(1) default '0',
  inlineReport character varying(1) default '0',
  no_of_try_runreport integer DEFAULT 1,
  no_of_try_approval integer DEFAULT 1,
  no_of_try_groupapproval integer DEFAULT 1,
  no_of_try_email integer DEFAULT 1,
  try_frequency_runreport character varying(10),
  try_frequency_approval character varying(10),
  try_frequency_groupapproval character varying(10),
  try_frequency_email character varying(10),
  servedby character varying(255),
  groupruntype character varying(255),
  groupexecution character varying(255),
  sched_pattern character varying(255),
  approvalto_id character varying(255),
  approvalto_entity character varying(255),
  groupapprovalto_id character varying(255),
  groupapprovalto_entity character varying(255),
  approvedby character varying(255),
  groupapprovedby character varying(255),
  approvalnotificationid integer,
  grpapprovalnotificationid integer,
  groupname character varying(255),
  reportenduser character varying(255),
  requestfor character varying(255),
  output_privileges text,
  output_visibility character varying(255),
  output_suffix character varying(255),
  email_templateid integer,
  recurringid integer,
  nextcreated character(1) DEFAULT 0,
  nbid integer default 0,
  CONSTRAINT ai_request_pkey PRIMARY KEY (id)
);

CREATE TABLE ai_request_task
(
  id serial NOT NULL,
  requestid integer,
  name character varying(255),
  status character varying(255),
  comments text,
  username character varying(255),
  trial integer,
  starttime timestamp without time zone,
  endtime timestamp without time zone,
  errorlog character varying(255),
  CONSTRAINT ai_request_task_pkey PRIMARY KEY (id)
);

CREATE TABLE ai_notification
(
  id serial NOT NULL,
  user_rolename character varying(255),
  notifiedto character varying(255),
  readstatus integer,
  message character varying(255),
  notification_type character varying(255),
  createdon timestamp without time zone,
  acknowledgement character varying(255),
  acknowledgedby character varying(255),
  acknowledgedon timestamp without time zone,
  comments text,
  approvalreport_outputtype character varying(255),
  approvalreport_outputid integer,
  sender character varying(255),
  CONSTRAINT ai_notification_pkey PRIMARY KEY (id)
);

CREATE TABLE ai_recurring_request
(
  id serial NOT NULL,
  requestid integer,
  username character varying(255),
  description character varying(255),
  schedulepattern character varying(255),
  scheduletime time without time zone,
  startdate timestamp without time zone,
  enddate timestamp without time zone,
  status character varying(255),
  nextruntime timestamp without time zone,
  lastruntime timestamp without time zone,
  CONSTRAINT ai_recurring_request_pkey PRIMARY KEY (id)
);

CREATE TABLE ai_request_parameter
(
  id serial NOT NULL,
  requestid integer,
  paramname character varying(255),
  paramvalue text,
  paramdatatype character varying(255),
  CONSTRAINT ai_request_parameter_pkey PRIMARY KEY (id),
  CONSTRAINT ai_request_parameter_requestid_fkey FOREIGN KEY (requestid)
      REFERENCES public.ai_request (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE ai_filetype
(
  id serial NOT NULL,
  isoutputtype integer,
  filetype character varying(255),
  longdescription character varying(255),
  classname character varying(255),
  CONSTRAINT ai_filetype_pkey PRIMARY KEY (id),
  CONSTRAINT ai_filetype_filetype_key UNIQUE (filetype)
);

CREATE TABLE ai_filetype_output
(
  id serial NOT NULL,
  filetype character varying(45),
  outputtype character varying(45)
);

CREATE TABLE ai_filefolder_output
(
  id serial NOT NULL,
  fileid integer,
  outputtype character varying(45),
  CONSTRAINT ai_filefolder_output_fileid_fkey FOREIGN KEY (fileid) REFERENCES public.ai_fileandfolder (id) ON DELETE CASCADE
);

CREATE TABLE ai_role
(
  id serial NOT NULL,
  name character varying(255),
  description character varying(255),
  email character varying(255),
  dashboardoption character varying(1) default '0',
  alertsOption character varying(1) default '0',
  reportOption character varying(1) default '0',
  mergeReportOption character varying(1) default '0',
  adhocOption character varying(1) default '0',
  resourceOption character varying(1) default '0',
  quickRunOption character varying(1) default '0',
  mappingOption character varying(1) default '0',
  messageOption character varying(1) default '0',
  datasetOption character varying(1) default '0',
  parameterOption character varying(1) default '0',
  annotationOption character varying(1) default '0',
  notificationOption character varying(1) default '0',
  requestOption character varying(1) default '0',
  adminOption character varying(1) default '0',
  scheduleOption character varying(1) default '0',
  department character varying(255),
  CONSTRAINT ai_role_pkey PRIMARY KEY (id),
  CONSTRAINT ai_role_name_key UNIQUE (name)
);

CREATE TABLE ai_user_role
(
  id serial NOT NULL,
  userName character varying(255),
  roleName character varying(255),
  CONSTRAINT ai_user_role_pkey PRIMARY KEY (id),
  CONSTRAINT ai_user_role_ukey UNIQUE (userName,roleName)
);

CREATE TABLE ai_parameter
(
  id serial NOT NULL,
  name character varying(255),
  datatype character varying(255),
  format character varying(255),
  displayname character varying(255),
  displaytype character varying(255),
  defaultvalue character varying(255),
  defaultvaluetype character varying(255),
  helptext character varying(255),
  isvisible integer,
  isrequired integer,
  filterby character varying(255),
  filtercondition character varying(255),
  linkedparam character varying(255),
  datasetid integer,
  datasetcolumnname character varying(255),
  value_displaytext text,
  username character varying(255),
  CONSTRAINT ai_parameter_pkey PRIMARY KEY (id)
);

CREATE TABLE ai_quickrun
(
  id serial NOT NULL,
  name character varying(255),
  reportid integer,
  username character varying(255),
  CONSTRAINT ai_quickrun_pkey PRIMARY KEY (id)
);

CREATE TABLE ai_quickrun_parameter
(
  id serial NOT NULL,
  quickrunid integer,
  paramname character varying(255),
  paramvalue character varying(255),
  paramdatatype character varying(255),
  CONSTRAINT ai_quickrun_parameter_pkey PRIMARY KEY (id),
  CONSTRAINT ai_quickrun_parameter_quickrunid_fkey FOREIGN KEY (quickrunid)
      REFERENCES public.ai_quickrun (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE
);

CREATE TABLE ai_audit
(
  id serial NOT NULL,
  resourceid character varying(255),
  resourcetype character varying(255),
  actiontype character varying(255),
  username character varying(255),
  starttime timestamp without time zone,
  comments character varying(255),
  oldvalues character varying(255),
  newvalues character varying(255),
  CONSTRAINT ai_audit_pkey PRIMARY KEY (id)
);

CREATE TABLE ai_email_users(
displayname character varying(255),
email character varying(255),
status character varying(50),
department character varying(255),
CONSTRAINT ai_email_users_pkey PRIMARY KEY (email,department)
);

CREATE TABLE ai_ldap_user_role
(
  user_role character varying(255) NOT NULL,
  user_rolename character varying(255) NOT NULL,
  default_dashboard character varying(255),
  dashboardoption character varying(1) default '0',
  alertsOption character varying(1) default '0',
  olapAnalyticsOption character varying(1) default '0',
  reportOption character varying(1) default '0',
  mergeReportOption character varying(1) default '0',
  adhocOption character varying(1) default '0',
  resourceOption character varying(1) default '0',
  quickRunOption character varying(1) default '0',
  mappingOption character varying(1) default '0',
  messageOption character varying(1) default '0',
  datasetOption character varying(1) default '0',
  listOfValuesOption character varying(1) default '0',
  parameterOption character varying(1) default '0',
  annotationOption character varying(1) default '0',
  notificationOption character varying(1) default '0',
  requestOption character varying(1) default '0',
  recurringOption character varying(1) default '0',
  adminOption character varying(1) default '0',
  scheduleOption character varying(1) default '0',
  CONSTRAINT ai_ldap_user_role_pkey PRIMARY KEY (user_role, user_rolename)
);

CREATE TABLE ai_quicklink
(
  id serial NOT NULL,
  owner character varying(255),
  name character varying(255),
  link character varying(255),
  path character varying(255),
  shortcutkey character varying(255),
  CONSTRAINT ai_quicklink_pkey PRIMARY KEY (id),
  CONSTRAINT ai_quicklink_name_key UNIQUE (name)
);

CREATE TABLE ai_dm
(
  id serial NOT NULL,
  type character varying(255),
  subject character varying(255),
  description text,
  owner character varying(255),
  visibility character varying(255),
  active character varying(255),
  start_date timestamp without time zone,
  end_date timestamp without time zone,
  created_on timestamp without time zone,
  lastupdated_on timestamp without time zone,
  option1 character varying(255),
  option2 character varying(255),
  option3 character varying(255),
  option4 character varying(255),
  option5 character varying(255),
  option6 character varying(255),
  option7 character varying(255),
  option8 character varying(255),
  option9 character varying(255),
  option10 character varying(255),
  CONSTRAINT ai_dm_pkey PRIMARY KEY (id)
);

CREATE TABLE ai_dm_applicable_area
(
  id serial NOT NULL,
  dm_id integer,
  applicableto_area character varying(255),
  applicableto_area_val character varying(255)
);

CREATE TABLE ai_dm_detail
(
  id serial NOT NULL,
  dm_id integer,
  acknowledging_user character varying(255),
  comments text,
  owner character varying(255),
  optionselected character varying(255),
  datetime timestamp without time zone,
  owner_count integer,
  user_count integer,
  CONSTRAINT ai_dm_detail_pkey PRIMARY KEY (id)
);

CREATE TABLE ai_dm_privilege
(
  id serial NOT NULL,
  dm_id integer,
  privilegetype character varying(255),
  user_rolename character varying(255),
  isacknowledged character varying(1) DEFAULT 0,
  CONSTRAINT ai_dm_privilege_pkey PRIMARY KEY (id)
);

CREATE TABLE ai_usertype_map
(
  id serial NOT NULL,
  usertype character varying(255),
  descriptionname character varying(255)
);

CREATE TABLE ai_backupuser
(
  id serial NOT NULL,
  username character varying(255),
  backupuser character varying(255),
  startdate timestamp without time zone,
  enddate timestamp without time zone,
  CONSTRAINT ai_backupuser_username_pkey PRIMARY KEY (username)
);


CREATE TABLE ai_im_comments
(
  id serial NOT NULL,
  notification_id integer,
  comments text,
  owner_count integer,
  user_count integer,
  CONSTRAINT ai_im_comments_pkey PRIMARY KEY (id)
);

CREATE TABLE ai_timezone
(
  id serial NOT NULL,
  name character varying(50) NOT NULL,
  value character varying(10) DEFAULT NULL,
  CONSTRAINT ai_timezone_pkey PRIMARY KEY (id)
);

CREATE TABLE ai_license
(
  machine_id character varying(255) NOT NULL,
  machine_name character varying(255) NOT NULL,
  license_filename character varying(255) NOT NULL,
  cpuoruser integer,
  created_on timestamp without time zone,
  expiry_date timestamp without time zone,
  last_used timestamp without time zone,
  status character varying(10) NOT NULL,
  is_primary integer DEFAULT 0,
  ulimit integer DEFAULT 0,
  token character varying(255) NOT NULL,
  CONSTRAINT ai_license_machine_name_key UNIQUE (machine_name)
);

CREATE TABLE ai_event(
id serial NOT NULL,
description character varying(255) DEFAULT NULL,
type character varying(255) DEFAULT NULL,
event_number character varying(10) NOT NULL,
owner character varying(255) DEFAULT NULL,
email_templateId integer DEFAULT 0,
CONSTRAINT ai_event_pkey PRIMARY KEY (id),
CONSTRAINT ai_event_number UNIQUE (owner,event_number)
);


CREATE TABLE ai_event_request(
id serial NOT NULL,
event_id integer,
request_id integer,
CONSTRAINT ai_event_request_eventid_fkey FOREIGN KEY (event_id) REFERENCES public.ai_event (id) ON DELETE CASCADE,
CONSTRAINT ai_event_request_requestid_fkey FOREIGN KEY (request_id) REFERENCES public.ai_request (id) ON DELETE CASCADE	  
);

CREATE TABLE ai_event_mail(
id serial NOT NULL,
event_id integer,
entity character varying(10) NOT NULL,
recipient text NOT NULL,
CONSTRAINT ai_event_mail_id_fkey foreign key(event_id) REFERENCES public.ai_event (id) ON DELETE CASCADE
);

CREATE TABLE ai_external_db(
dbKey character varying(255),
dbName character varying(255) NOT NULL,
CONSTRAINT ai_extdb_pkey PRIMARY KEY (dbKey)
);

CREATE TABLE ai_extdb_priv(
id serial NOT NULL,
dbKey character varying(255),
privilegeType character varying(10) NOT NULL,
user_roleName character varying(255) NOT NULL,
CONSTRAINT ai_extdb_priv_fkey foreign key(dbKey) REFERENCES public.ai_external_db (dbKey) ON DELETE CASCADE
);

CREATE TABLE ai_annotation (
  id serial NOT NULL,
  annotationKey character varying(255),
  description text,
  shortDescription character varying(255),
  startDate date,
  endDate date,
  groupName character varying(255),
  owner character varying(255),
  visibilityType character varying(255),
  CONSTRAINT ai_annotation_pkey PRIMARY KEY (id)
);

CREATE TABLE ai_lovrow_mapping(
id serial NOT NULL,
lovId integer default NULL,
mapId integer default NULL,
rowNo character varying(255) default NULL,
owner character varying(255) NOT NULL,
comments character varying(1000) default NULL,
CONSTRAINT ai_lovrow_mapping_pkey PRIMARY KEY (id)
);

CREATE TABLE ai_report_management(	
id serial NOT NULL, 
lovId integer DEFAULT NULL, 
lovMappingId integer DEFAULT NULL, 
lovRowId character varying(255) DEFAULT NULL, 
name character varying(255) DEFAULT NULL, 
previousRunId integer DEFAULT NULL, 
previousRunTime timestamp without time zone DEFAULT NULL, 
currentRunId integer DEFAULT NULL, 
currentRunTime timestamp without time zone DEFAULT NULL, 
owner character varying(255) DEFAULT NULL, 
comments character varying(1000) DEFAULT NULL,
CONSTRAINT ai_report_management_pkey PRIMARY KEY (id),
CONSTRAINT ai_report_management_lovId_fkey FOREIGN KEY (lovId) REFERENCES public.ai_fileandfolder(id),
CONSTRAINT ai_report_management_lovMappingId_fkey FOREIGN KEY (lovMappingId) REFERENCES public.ai_fileandfolder(id)	
);

CREATE TABLE ai_datasource (
id serial NOT NULL,
protocol character varying(500),
type_database character varying(500) DEFAULT NULL,
name character varying(500) DEFAULT NULL,
jndi character varying(500) NOT NULL DEFAULT '0',
driver_class_name character varying(500) DEFAULT NULL,
url character varying(1000) DEFAULT NULL,
username character varying(1000) DEFAULT NULL,
password character varying(1000) DEFAULT NULL,
g_credential character varying(1000) DEFAULT NULL,
g_key_type character varying(255) DEFAULT NULL,
g_project_id character varying(1000) DEFAULT NULL,
g_filename character varying(1000) DEFAULT NULL,
g_service_account_id character varying(1000) DEFAULT NULL,
olapDriver character varying(255) DEFAULT NULL,
olapConnStr character varying(255) DEFAULT NULL,
waitTime BIGINT DEFAULT NULL,
department character varying(8),
extra_info text DEFAULT '{}',
CONSTRAINT ai_datasource_pkey PRIMARY KEY (id)
);

CREATE TABLE ai_datasource_type (
id serial NOT NULL,
protocol character varying(500),
type_database character varying(500),
driver_class_name character varying(500),
url character varying(1000),
CONSTRAINT ai_datasource_type_pkey PRIMARY KEY (id)
);


CREATE TABLE ai_time_scheduler_cron (
  id serial NOT NULL,
  actual_end_time timestamp without time zone NULL DEFAULT NULL,
  actual_start_time timestamp without time zone NULL DEFAULT NULL,
  cron_expression character varying(50) DEFAULT NULL,
  end_time timestamp without time zone NULL DEFAULT NULL,
  interval_time character varying(255) DEFAULT NULL,
  start_time timestamp without time zone NULL DEFAULT NULL,
  status character varying(50) DEFAULT NULL,
  type_of_job character varying(50) DEFAULT NULL,
  extra_info text DEFAULT NULL,
  req_rec_id integer,
  server character varying(255) DEFAULT NULL,
  name character varying(45) DEFAULT NULL,
  CONSTRAINT ai_time_scheduler_cron_pkey PRIMARY KEY (id)
);

CREATE TABLE ai_alertSuccess
   (	id serial NOT NULL, 
	alertId integer DEFAULT NULL, 
	status character varying(255), 
	conditionName character varying(500), 
	dateExecuted timestamp without time zone,
	mailedTo character varying(255), 
	owner character varying(255), 
	actualValue character varying(255), 
	valOne character varying(1000), 
	valTwo character varying(1000), 
	CONSTRAINT ai_alertSuccess_pkey PRIMARY KEY (id)	
	);
	
	
CREATE TABLE ai_file_output (
 id serial NOT NULL,
 fileid integer,
 oid integer,
 status character varying(45) DEFAULT NULL,
 CONSTRAINT ai_file_output_pkey PRIMARY KEY (id),
 CONSTRAINT ai_file_output_fileid_fkey FOREIGN KEY (fileid) REFERENCES public.ai_fileandfolder(id)
);

CREATE EXTENSION intarray;

insert into ai_category(id,category,folderPath) 
values (1,'REPORTS','/Documents/Reports'),
(2,'QUICKRUN','/Documents/QuickRun'),
(3,'MAPPING','/Documents/Mapping'),
(4,'DASHBOARD','/Dashboard/Dashboards'),
(5,'WIDGET','/Dashboard/Widgets'),
(6,'DATASETS','/Data/DataSets'),
(7,'DATASOURCES','/Data/DataSources'),
(8,'LISTOFVALUES','/Data/ListOfValues'),
(9,'PARAMETERS','/Data/Parameters'),
(10,'APPROVAL','/Approval'),
(11,'RESOURCES','/Resources'),
(12,'ALERTS','/Data/Alerts'),
(13,'MERGE','/Documents/Merge'),
(14,'OLAP_ANALYTIC','/Dashboard/OlapAnalytics'),
(15,'ADHOC','/Documents/Adhoc');

SELECT SETVAL('ai_category_id_seq', (SELECT MAX(id) from ai_category));

INSERT INTO ai_filetype(id,isOutputType,fileType,longDescription)
VALUES (1,1,'csv','Comma Seprated Value file'),
(2,0,'rptdesign','Birt report design file'),
(3,1,'rptdocument','Birt report document file'),
(4,0,'jrxml','Jasper report file'),
(5,0,'jasper','Jasper Compiled report file'),
(6,0,'prpt','Pentaho report design file'),
(7,1,'prptdocument','Pentaho report document file'),
(8,1,'pdf','Portable document format file'),
(9,1,'png','Portable Network Graphics image'),
(10,1,'jpeg','Joint Photographic Experts Group image'),
(11,1,'jpg','Joint Photographic Experts Group image'),
(12,1,'css','Cascading Style Sheets file'),
(13,1,'etemp','Email Template file'),
(14,1,'js','Javascript file'),
(15,1,'docx','Microsoft word file'),
(16,1,'doc','Microsoft word file'),
(17,1,'rtf','Rich text format file'),
(18,1,'xlsx','Microsoft excel file'),
(19,1,'xls','Microsoft excel file'),
(20,1,'xlsm','Macro Enabled Spreadsheet'),
(21,1,'json','Javascript object Notation'),
(22,1,'rptlibrary','Birt report library'),
(23,1,'rpttemplate','Birt report template'),
(24,1,'merge','Merge report file'),
(25,1,'map','Mapping file'),
(26,1,'xml','XML file'),
(27,1,'html','Hypertext markup language file'),
(28,1,'phtml','Paginated html file'),
(29,1,'dash','Dashboard file'),
(30,1,'dashboard','Cached Dashboard file'),
(31,1,'txt','Plain text file'),
(32,0,'report','Fly Report file'),
(33,1,'ds','Dataset file'),
(34,1,'cds','Cached Dataset file'),
(35,0,'template','Fly Report template'),
(36,1,'pptx','Microsoft power point file'),
(37,0,'ipynb','Jupyter Notebook'),
(38,1,'gbr','Group Bursting Report'),
(39,1,'stash','Group Dataset'),
(40,1,'dml','DML'),
(41,1,'adhoc','ADHOC File'),
(42,1,'aiv-xlsx','AIV XLSX');

SELECT SETVAL('ai_filetype_id_seq', (SELECT MAX(id) from ai_filetype));

INSERT INTO ai_filetype_output(id,fileType, outputType)
VALUES (1,'rptdesign','rptdocument'), 
(2,'rptdesign','html'),
(3,'rptdesign','pdf'),
(4,'rptdesign','xlsx'),
(5,'rptdesign','docx'),
(6,'rptdesign','xls'),
(7,'rptdesign','xls_spudsoft'),
(8,'jrxml','phtml'), 
(9,'jrxml','html'),
(10,'jrxml','pdf'),
(11,'jrxml','xls'),
(12,'jrxml','docx'),
(13,'jasper','phtml'), 
(14,'jasper','html'),
(15,'jasper','pdf'),
(16,'jasper','xls'),
(17,'jasper','docx'),
(18,'prpt','prptdocument'),
(19,'prpt','html'),
(20,'prpt','pdf'),
(21,'prpt','xls'),
(22,'prpt','csv'),
(23,'prpt','rtf'),
(24,'prpt','xml'),
(25,'prpt','txt'),
(26,'report','html'),
(27,'report','xlsx'),
(28,'report','xls_spudsoft'),
(29,'report','pdf'),
(30,'rptdesign','pptx'),
(31,'ipynb','pdf'),
(32,'rptdesign','aiv-xlsx');

SELECT SETVAL('ai_filetype_output_id_seq', (SELECT MAX(id) from ai_filetype_output));

INSERT INTO  ai_usertype_map(id,userType,descriptionName)
values
(1,'INT','Advanced User'),
(2,'EXT','End User');

SELECT SETVAL('ai_usertype_map_id_seq', (SELECT MAX(id) from ai_usertype_map));

insert into ai_timezone values 
(1,'ACDT Australian Central Daylight Time','+10:30'),
(2,'ACST Australian Central Standard Time','+9:30'),
(3,'ADT Atlantic Daylight Time','-3:00'),
(4,'AEDT Australian Eastern Daylight Time','+11:00'),
(5,'AEST Australian Eastern Standard Time','+10:00'),
(6,'AKDT Alaska Standard Daylight Saving Time','-8:00'),
(7,'AKST Alaska Standard Time','-9:00'),
(8,'AST Atlantic Standard Time','-4:00'),
(9,'AWST Australian Western Standard Time','+8:00'),
(10,'BST British Summer Time','+1:00'),
(11,'CDT Central Daylight Saving Time','-5:00'),
(12,'CEST Central Europe Summer Time','+2:00'),
(13,'CET Central Europe Time','+1:00'),
(14,'CST Central Standard Time','-6:00'),
(15,'Default','SYSTEM'),
(16,'EDT Eastern Daylight Saving Time','-4:00'),
(17,'EEST Eastern Europe Summer Time','+3:00'),
(18,'EET Eastern Europe Time','+2:00'),
(19,'EST Eastern Standard Time','-5:00'),
(20,'GMT Greenwich Mean Time','+00:00'),
(21,'HST Hawaiian Standard Time','-10:00'),
(22,'IST Indian Standard Time','+5:30'),
(23,'IST Irish Summer Time','+1:00'),
(24,'MDT Mountain Daylight Saving Time','-6:00'),
(25,'MSD Moscow Summer Time','+4:00'),
(26,'MSK Moscow Time','+3:00'),
(27,'MST Mountain Standard Time','-7:00'),
(28,'PDT Pacific Daylight Saving Time','-7:00'),
(29,'PST Pacific Standard Time','-8:00'),
(30,'WEST Western Europe Summer Time','+1:00'),
(31,'WET Western Europe Time','+00:00');

SELECT SETVAL('ai_timezone_id_seq', (SELECT MAX(id) from ai_timezone));

insert into ai_user values 
(1,'Admin',NULL,'Admin','Active','8989899D2C314FF543657C44BF8EAB10',NULL,'/Admin','2','0',2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,'INT','47|:|Solution Dashboard|:|Admin','Visualization/GridDashboard','en','SYSTEM','Default','0','Default'),
(2,'Paul','Smith','Demo','Active','8989899D2C314FF543657C44BF8EAB10','Paul@aivhub.com','/Demo','1','0',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'INT',NULL,'Documents/Reports','en','SYSTEM','Default','0','Default');

SELECT SETVAL('ai_user_id_seq', (SELECT MAX(id) from ai_user));

insert into ai_role values 
(1,'Administrator','Administrator Role','admin-a@aivhub.com',2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,'Default'),
(2,'Sales','Sales Role','support@aivhub.com',1,1,1,1,2,0,1,1,1,0,0,2,1,1,0,2,'Default');

SELECT SETVAL('ai_role_id_seq', (SELECT MAX(id) from ai_role));

insert into ai_user_role values 
(1,'Demo','Sales'),
(2,'Admin','Administrator');

SELECT SETVAL('ai_user_role_id_seq', (SELECT MAX(id) from ai_user_role));

insert into ai_dm (id,type,subject,description,owner,visibility,active,start_date,end_date,created_on,lastupdated_on,option1,option2,option3,option4,option5,option6,option7,option8,option9,option10) values 
(1,'RATING','Welcome to Adhoc Reports','<p><span>Adhoc Reports/Edit Reports</span><span> will help you to add report and also make changes in existing report to create customize reports.</span></p><p>Rate on the Prescribed Scale about Your Experience working on adhoc Reports.</p>','Admin','PUB','ACTIVE',null,null,now(),now(),'1','2','3','4','5',null,null,null,null,null),
(2,'FEEDBACK','Welcome to List of Values','<p><span>List of values</span><span> is a list that containing the data values associated with an object.</span></p><p><span>Share With us your Feedback regarding the Features in list of values.</span></p>','Admin','PUB','ACTIVE',null,null,now(),now(),'Least Important','Important','Most Important',null,null,null,null,null,null,null),
(3,'RATING','Welcome to Annotations','<p><span>Annotations </span><span>are critical or explanatory notes added to a text, image or other data. They are references that point to the specific part of data.</span></p><p>Rate on the Prescribed Scale about Your Experience working on Annotations.</p>','Admin','PUB','ACTIVE',null,null,now(),now(),'1','2','3','4','5',null,null,null,null,null);

SELECT SETVAL('ai_dm_id_seq', (SELECT MAX(id) from ai_dm));

insert into ai_dm_applicable_area (dm_id,applicableto_area,applicableto_area_val) values 
(1,'SECTION','EDITREPORT'),
(2,'SECTION','LISTOFVALUES'),
(3,'SECTION','ANNOTATIONS');

SELECT SETVAL('ai_dm_applicable_area_id_seq', (SELECT MAX(id) from ai_dm_applicable_area));

insert into ai_dm_privilege (id,dm_id,privilegetype,user_rolename,isacknowledged) values 
(1,1,'USER','Admin',0),
(2,1,'USER','Demo',0),
(3,2,'USER','Admin',0),
(4,2,'USER','Demo',0),
(5,3,'USER','Admin',0),
(6,3,'USER','Demo',0);

SELECT SETVAL('ai_dm_privilege_id_seq', (SELECT MAX(id) from ai_dm_privilege));

Insert into ai_fileandfolder (id,description,owner,rootfolder,category,path,name,type,versionno,visibilitytype,visible,createdby,createdon,isdefault,lastupdatedon,lastupdatedby,isarchivable,isarchived,ispurgeable,ispurged) values 
(1,'Documents parent folder','Demo','/Demo',null,'/','Documents','folder',1,'PVT',1,'Demo',now(),'1',now(),'Demo',0,0,0,0),
 (2,'Reports folder','Demo','/Demo',null,'/Documents/','Reports','folder',1,'PVT',1,'Demo',now(),'1',now(),'Demo',0,0,0,0),
 (3,'Output folder','Demo','/Demo','REPORTS','/','Output','folder',1,'PVT',1,'Demo',now(),'1',now(),'Demo',0,0,0,0),
 (4,'Templates folder','Demo','/Demo','REPORTS','/','Templates','folder',1,'PVT',1,'Demo',now(),'1',now(),'Demo',0,0,0,0),
 (5,'Temp folder','Demo','/Demo','REPORTS','/Output/','Temp','folder',1,'PVT',1,'Demo',now(),'1',now(),'Demo',0,0,0,0),
 (6,'Quickrun folder','Demo','/Demo',null,'/Documents/','QuickRun','folder',1,'PVT',1,'Demo',now(),'1',now(),'Demo',0,0,0,0),
 (7,'Mapping folder','Demo','/Demo',null,'/Documents/','Mapping','folder',1,'PVT',1,'Demo',now(),'1',now(),'Demo',0,0,0,0),
 (8,'Merge folder','Demo','/Demo',null,'/Documents/','Merge','folder',1,'PVT',1,'Demo',now(),'1',now(),'Demo',0,0,0,0),
 (9,'Manage data parent folder','Demo','/Demo',null,'/','Data','folder',1,'PVT',1,'Demo',now(),'1',now(),'Demo',0,0,0,0),
 (10,'List of values folder','Demo','/Demo',null,'/Data/','ListOfValues','folder',1,'PVT',1,'Demo',now(),'1',now(),'Demo',0,0,0,0),
 (11,'Parameter folder','Demo','/Demo',null,'/Data/','Parameters','folder',1,'PVT',1,'Demo',now(),'1',now(),'Demo',0,0,0,0),
 (12,'Dataset folder','Demo','/Demo',null,'/Data/','DataSets','folder',1,'PVT',1,'Demo',now(),'1',now(),'Demo',0,0,0,0),
 (13,'DataSources folder','Demo','/Demo',null,'/Data/','DataSources','folder',1,'PVT',1,'Demo',now(),'1',now(),'Demo',0,0,0,0),
 (14,'Dashboard parent folder','Demo','/Demo',null,'/','Dashboard','folder',1,'PVT',1,'Demo',now(),'1',now(),'Demo',0,0,0,0),
 (15,'Dashboards folder','Demo','/Demo',null,'/Dashboard/','Dashboards','folder',1,'PVT',1,'Demo',now(),'1',now(),'Demo',0,0,0,0),
 (16,'Widgets folder','Demo','/Demo',null,'/Dashboard/','Widgets','folder',1,'PVT',1,'Demo',now(),'1',now(),'Demo',0,0,0,0),
 (17,'Analytics folder','Demo','/Demo',null,'/Dashboard/','Analytics','folder',1,'PVT',1,'Demo',now(),'1',now(),'Demo',0,0,0,0),
 (18,'Dashboard Reports folder','Demo','/Demo',null,'/Dashboard/','Reports','folder',1,'PVT',1,'Demo',now(),'1',now(),'Demo',0,0,0,0),
 (19,'Documents parent folder','Admin','/Admin',null,'/','Documents','folder',1,'PVT',1,'Admin',now(),'1',now(),'Admin',0,0,0,0),
 (20,'Reports folder','Admin','/Admin',null,'/Documents/','Reports','folder',1,'PVT',1,'Admin',now(),'1',now(),'Admin',0,0,0,0),
 (21,'Output folder','Admin','/Admin','REPORTS','/','Output','folder',1,'PVT',1,'Admin',now(),'1',now(),'Admin',0,0,0,0),
 (22,'Templates folder','Admin','/Admin','REPORTS','/','Templates','folder',1,'PVT',1,'Admin',now(),'1',now(),'Admin',0,0,0,0),
 (23,'Temp folder','Admin','/Admin','REPORTS','/Output/','Temp','folder',1,'PVT',1,'Admin',now(),'1',now(),'Admin',0,0,0,0),
 (24,'Quickrun folder','Admin','/Admin',null,'/Documents/','QuickRun','folder',1,'PVT',1,'Admin',now(),'1',now(),'Admin',0,0,0,0),
 (25,'Mapping folder','Admin','/Admin',null,'/Documents/','Mapping','folder',1,'PVT',1,'Admin',now(),'1',now(),'Admin',0,0,0,0),
 (26,'Merge folder','Admin','/Admin',null,'/Documents/','Merge','folder',1,'PVT',1,'Admin',now(),'1',now(),'Admin',0,0,0,0),
 (27,'Manage data parent folder','Admin','/Admin',null,'/','Data','folder',1,'PVT',1,'Admin',now(),'1',now(),'Admin',0,0,0,0),
 (28,'List of values folder','Admin','/Admin',null,'/Data/','ListOfValues','folder',1,'PVT',1,'Admin',now(),'1',now(),'Admin',0,0,0,0),
 (29,'Parameter folder','Admin','/Admin',null,'/Data/','Parameters','folder',1,'PVT',1,'Admin',now(),'1',now(),'Admin',0,0,0,0),
 (30,'Dataset folder','Admin','/Admin',null,'/Data/','DataSets','folder',1,'PVT',1,'Admin',now(),'1',now(),'Admin',0,0,0,0),
 (31,'DataSources folder','Admin','/Admin',null,'/Data/','DataSources','folder',1,'PVT',1,'Admin',now(),'1',now(),'Admin',0,0,0,0),
 (32,'Dashboard parent folder','Admin','/Admin',null,'/','Dashboard','folder',1,'PVT',1,'Admin',now(),'1',now(),'Admin',0,0,0,0),
 (33,'Dashboards folder','Admin','/Admin',null,'/Dashboard/','Dashboards','folder',1,'PVT',1,'Admin',now(),'1',now(),'Admin',0,0,0,0),
 (34,'Widgets folder','Admin','/Admin',null,'/Dashboard/','Widgets','folder',1,'PVT',1,'Admin',now(),'1',now(),'Admin',0,0,0,0),
 (35,'Analytics folder','Admin','/Admin',null,'/Dashboard/','Analytics','folder',1,'PVT',1,'Admin',now(),'1',now(),'Admin',0,0,0,0),
 (36,'Dashboard Reports folder','Admin','/Admin',null,'/Dashboard/','Reports','folder',1,'PVT',1,'Admin',now(),'1',now(),'Admin',0,0,0,0),
 (37,null,'Admin',null,'DATASETS','/','Customers','cds',1,'PUB',1,'Admin',now(),'1',now(),'Admin',1,0,1,0),
 (38,null,'Admin',null,'DATASETS','/','Overall Sales','cds',1,'PUB',1,'Admin',now(),'1',now(),'Admin',1,0,1,0),
 (39,null,'Admin',null,'DATASETS','/','Sales Representative','cds',1,'PUB',1,'Admin',now(),'1',now(),'Admin',1,0,1,0),
 (40,null,'Admin',null,'DATASETS','/','Sales','cds',1,'PUB',1,'Admin',now(),'1',now(),'Admin',1,0,1,0),
 (41,null,'Admin',null,'DATASETS','/','Top 5 Customers','cds',1,'PUB',1,'Admin',now(),'1',now(),'Admin',1,0,1,0),
 (42,null,'Admin',null,'DATASETS','/','Top 5 Sales Representative','cds',1,'PUB',1,'Admin',now(),'1',now(),'Admin',1,0,1,0),
 (43,null,'Admin',null,'DATASETS','/','Product Details','cds',1,'PUB',1,'Admin',now(),'1',now(),'Admin',1,0,1,0),
 (44,null,'Admin',null,'LISTOFVALUES','/','Overall','lov',1,'PUB',1,'Admin',now(),'1',now(),'Admin',1,0,1,0),
 (45,null,'Admin',null,'DASHBOARD','/','Overall Performance','dash',1,'PUB',1,'Admin',now(),'1',now(),'Admin',1,0,1,0),
 (47,null,'Admin',null,'DASHBOARD','/','Solution Dashboard','dash',1,'PUB',1,'Admin',now(),'1',now(),'Admin',1,0,1,0),
 (48,null,'Admin',null,'ANALYTIC','/','Product Analysis','ana',1,'PUB',1,'Admin',now(),'1',now(),'Admin',1,0,1,0),
 (49,null,'Admin',null,'REPORTS','/Templates/','Annotations','rptdesign',1,'PUB',1,'Admin',now(),'1',now(),'Admin',1,0,1,0),
 (50,null,'Admin',null,'REPORTS','/Templates/','Customers details','rptdesign',1,'PUB',1,'Admin',now(),'1',now(),'Admin',1,0,1,0),
 (51,null,'Admin',null,'REPORTS','/Templates/','Invoice','jasper',1,'PUB',1,'Admin',now(),'1',now(),'Admin',1,0,1,0),
 (52,null,'Admin',null,'REPORTS','/Templates/','Orders Payment','rptdesign',1,'PUB',1,'Admin',now(),'1',now(),'Admin',1,0,1,0),
 (53,null,'Admin',null,'REPORTS','/Templates/','Sales by Productline','jasper',1,'PUB',1,'Admin',now(),'1',now(),'Admin',1,0,1,0),
 (54,null,'Admin',null,'REPORTS','/Templates/','Income Statement','prpt',1,'PUB',1,'Admin',now(),'1',now(),'Admin',1,0,1,0),
 (55,null,'Admin',null,'REPORTS','/Templates/','Sales by Year','rptdesign',1,'PUB',1,'Admin',now(),'1',now(),'Admin',1,0,1,0),
 (56,null,'Admin',null,'REPORTS','/Templates/','Top 5 Customers','rptdesign',1,'PUB',1,'Admin',now(),'1',now(),'Admin',1,0,1,0),
 (59,null,'Admin',null,'RESOURCES','/','common','folder',1,'PUB',1,null,now(),'1',now(),null,0,0,0,0),
 (60,null,'Admin',null,'RESOURCES','/common/','csv','folder',1,'PUB',1,null,now(),'1',now(),null,0,0,0,0),
 (61,null,'Admin',null,'RESOURCES','/common/','css','folder',1,'PUB',1,null,now(),'1',now(),null,0,0,0,0),
 (62,null,'Admin',null,'RESOURCES','/common/','js','folder',1,'PUB',1,null,now(),'1',now(),null,0,0,0,0),
 (63,null,'Admin',null,'RESOURCES','/common/','images','folder',1,'PUB',1,null,now(),'1',now(),null,0,0,0,0),
 (64,null,'Admin',null,'RESOURCES','/common/','libraries','folder',1,'PUB',1,null,now(),'1',now(),null,0,0,0,0),
 (65,null,'Admin',null,'RESOURCES','/common/csv/','Country','csv',1,'PUB',1,'Admin',now(),'1',now(),'Admin',1,0,1,0),
 (66,null,'Admin',null,'RESOURCES','/common/csv/','Overall Report Lov','csv',1,'PUB',1,'Admin',now(),'1',now(),'Admin',1,0,1,0),
 (67,null,'Admin',null,'RESOURCES','/common/css/','Blue','css',1,'PUB',1,'Admin',now(),'1',now(),'Admin',1,0,1,0),
 (68,null,'Admin',null,'RESOURCES','/common/images/','Cover1','jpg',1,'PUB',1,'Admin',now(),'1',now(),'Admin',1,0,1,0),
 (69,null,'Admin',null,'RESOURCES','/common/images/','Cover2','jpg',1,'PUB',1,'Admin',now(),'1',now(),'Admin',1,0,1,0),
 (70,null,'Admin',null,'RESOURCES','/common/images/','Cover3','jpg',1,'PUB',1,'Admin',now(),'1',now(),'Admin',1,0,1,0),
 (71,null,'Admin',null,'RESOURCES','/common/images/','Cover4','jpg',1,'PUB',1,'Admin',now(),'1',now(),'Admin',1,0,1,0),
 (72,null,'Admin',null,'RESOURCES','/common/images/','Cover5','jpg',1,'PUB',1,'Admin',now(),'1',now(),'Admin',1,0,1,0),
 (73,null,'Admin',null,'RESOURCES','/common/images/','Cover6','jpg',1,'PUB',1,'Admin',now(),'1',now(),'Admin',1,0,1,0),
 (74,null,'Admin',null,'RESOURCES','/common/images/','Cover7','jpg',1,'PUB',1,'Admin',now(),'1',now(),'Admin',1,0,1,0),
 (75,null,'Admin',null,'RESOURCES','/common/images/','Cover8','jpg',1,'PUB',1,'Admin',now(),'1',now(),'Admin',1,0,1,0),
 (76,null,'Admin',null,'RESOURCES','/common/images/','logo','png',1,'PUB',1,'Admin',now(),'1',now(),'Admin',1,0,1,0),
 (77,null,'Admin',null,'RESOURCES','/common/images/','logos','png',1,'PUB',1,'Admin',now(),'1',now(),'Admin',1,0,1,0),
 (78,null,'Admin',null,'RESOURCES','/common/libraries/','Component Library','rptlibrary',1,'PUB',1,'Admin',now(),'1',now(),'Admin',1,0,1,0),
 (79,null,'Admin',null,'RESOURCES','/common/libraries/','datasources','rptlibrary',1,'PUB',0,'Admin',now(),'1',now(),'Admin',1,0,1,0),
 (80,null,'Admin',null,'RESOURCES','/common/libraries/','themes','rptlibrary',1,'PUB',0,'Admin',now(),'1',now(),'Admin',1,0,1,0),
 (81,'Email Templates folder created','Admin',null,'RESOURCES','/','EmailTemplates','folder',1,'PUB',1,null,now(),'1',now(),null,0,0,0,0),
 (82,'Portrait report template','Admin',null,'RESOURCES','/','Portrait View','rpttemplate',1,'PUB',1,'Admin',now(),'1',now(),'Admin',1,0,1,0),
 (83,'Success email template','Admin',null,'RESOURCES','/EmailTemplates/','Success','etemp',1,'PUB',1,'Admin',now(),'1',now(),'Admin',1,0,1,0),
 (84,'Approval folder created','Admin',null,null,'/','Approval','folder',1,'PUB',1,'Admin',now(),'1',now(),'Admin',0,0,0,0),
 (85,'Resources folder created','Admin',null,null,'/','Resources','folder',1,'PUB',1,'Admin',now(),'1',now(),'Admin',0,0,0,0),
 (86,null,'Admin',null,'MAPPING','/','Annotations Mapping','map',1,'PUB',1,'Admin',now(),'1',now(),'Admin',1,0,1,0),
 (87,'Default email template','Admin',null,'RESOURCES','/EmailTemplates/','Default','etemp',1,'PUB',1,'Admin',now(),'1',now(),'Admin',1,0,1,0),
 (88,null,'Admin',null,'REPORTS','/Templates/','Order details','rptdesign',1,'PUB',1,'Admin',now(),'1',now(),'Admin',1,0,1,0),
 (89,null,'Admin',null,'REPORTS','/Templates/','Inventory','prpt',1,'PUB',1,'Admin',now(),'1',now(),'Admin',1,0,1,0),
 (90,'Olap Analytics folder','Demo','/Demo',null,'/Dashboard/','OlapAnalytics','folder',1,'PVT',1,'Demo',now(),'1',now(),'Demo',0,0,0,0),
 (91,'Olap Analytics folder','Admin','/Admin',null,'/Dashboard/','OlapAnalytics','folder',1,'PVT',1,'Admin',now(),'1',now(),'Admin',0,0,0,0),
 (92,'Adhoc folder','Demo','/Demo',null,'/Documents/','Adhoc','folder',1,'PVT',1,'Demo',now(),'1',now(),'Demo',0,0,0,0),
 (93,'Adhoc folder','Admin','/Admin',null,'/Documents/','Adhoc','folder',1,'PVT',1,'Admin',now(),'1',now(),'Admin',0,0,0,0),
 (94,'Report on the fly template','Admin',null,'RESOURCES','/','Report on the fly','rpttemplate',1,'PUB',0,'Admin',now(),'1',now(),'Admin',1,0,1,0),
 (95,'Landscape report template','Admin',NULL,'RESOURCES','/','Landscape View','rpttemplate',1,'PUB',1,'Admin',now(),1,now(),'Admin',1,0,1,0),
 (96,'','Admin',NULL,'RESOURCES','/common/images/','classicmodels','png',1,'PUB',1,'Admin',now(),1,now(),'Admin',1,0,1,0),
 (97,null,'Admin',null,'DATASETS','/','Top_5_Diagnosis','cds',1,'PUB',1,'Admin',now(),'1',now(),'Admin',1,0,1,0),
(98,null,'Admin',null,'DATASETS','/','Manufacturing','cds',1,'PUB',1,'Admin',now(),'1',now(),'Admin',1,0,1,0),
(99,null,'Admin',null,'DATASETS','/','Logistic','cds',1,'PUB',1,'Admin',now(),'1',now(),'Admin',1,0,1,0),
(100,null,'Admin',null,'DATASETS','/','Education','cds',1,'PUB',1,'Admin',now(),'1',now(),'Admin',1,0,1,0),
(101,null,'Admin',null,'DATASETS','/','Healthcare','cds',1,'PUB',1,'Admin',now(),'1',now(),'Admin',1,0,1,0),
(102,null,'Admin',null,'DATASETS','/','Energies & Utilities','cds',1,'PUB',1,'Admin',now(),'1',now(),'Admin',1,0,1,0);

 SELECT SETVAL('ai_fileandfolder_id_seq', (SELECT MAX(id) from ai_fileandfolder));


 insert into ai_annotation (id,annotationkey,description,shortdescription,startdate,enddate,groupname,owner,visibilitytype) values (1,'Group1','<p><strong>Dear User,</strong></p><p><strong>&nbsp;</strong></p><h3><strong>We are very excited to introduce </strong><span style="color: rgb(255, 194, 102);">Active Intelligence Visualization 5</span><strong> </strong><strong style="color: blue;">(AIV)</strong></h3><p><strong>&nbsp;</strong></p><p class="ql-align-justify"><strong>AIV 5 enable the user to analyze data and present actionable insights to help corporate executives, business managers and other end-users to make informed business decisions.</strong></p><p class="ql-align-justify"><strong>&nbsp;</strong></p><p class="ql-align-justify"><strong>AIV encompasses a variety of tools, applications and methodologies that enable organizations to collect data from internal systems and external sources, prepare it for analysis.&nbsp;You can develop and run queries against the data, create pixel-perfect reports and dashboards to make the analytical results available to corporate decision-makers and distribute &amp; share the report and analytics to internal users, partners and even the outside users in different file formats, such as Excel, PDF, PPT, and many more.</strong></p><h3 class="ql-align-justify"><br></h3><h4><strong><em>Active Intelligence Visualization Team</em></strong></h4><p><br></p><p class="ql-align-justify"><a href="https://aivhub.com/" rel="noopener noreferrer" target="_blank">Visit AIV</a></p><h3 class="ql-align-justify"><br></h3>','Announcement Messages',NULL,NULL,'Announcement Messages','Admin','PVT');
 insert into ai_annotation (id,annotationkey,description,shortdescription,startdate,enddate,groupname,owner,visibilitytype) values (2,'Product Launch','<p><strong style=\"color: rgb(51, 51, 51);\">Dear User,</strong></p><p><strong style=\"color: rgb(51, 51, 51);\">&nbsp;</strong></p><h3><strong style=\"color: rgb(51, 51, 51);\">We are very excited to introduce Active Intelligence Visualization 5 </strong><strong style=\"color: blue;\">(AIV)</strong></h3><p><strong style=\"color: rgb(51, 51, 51);\">&nbsp;</strong></p><p class=\"ql-align-justify\"><strong style=\"color: rgb(51, 51, 51);\">AIV 5 enable the user to analyze data and present actionable insights to help corporate executives, business managers and other end-users to make informed business decisions.</strong></p><p class=\"ql-align-justify\"><strong style=\"color: rgb(51, 51, 51);\">&nbsp;</strong></p><p class=\"ql-align-justify\"><strong style=\"color: rgb(51, 51, 51);\">AIV encompasses a variety of tools, applications and methodologies that enable organizations to collect data from internal systems and external sources, prepare it for analysis.&nbsp;You can develop and run queries against the data, create pixel-perfect reports and dashboards to make the analytical results available to corporate decision-makers and distribute &amp; share the report and analytics to internal users, partners and even the outside users in different file formats, such as Excel, PDF, PPT, and many more.</strong></p><h3 class=\"ql-align-justify\"><br></h3><h4><strong><em>Active Intelligence Visualization Team</em></strong></h4><p><br></p><p class=\"ql-align-justify\"><a href="https://aivhub.com" rel=\"noopener noreferrer\" target="_blank">Visit AIV</a></p>','Product announcements new launch',NULL,NULL,'Announcement Messages','Admin','PVT');
 
insert into ai_annotation (id,annotationkey,description,shortdescription,startdate,enddate,groupname,owner,visibilitytype) values (3,'Product Features','<h3><span style=\"color: rgb(51, 51, 51);\">Dear User,</span></h3><h3><span style=\"color: rgb(51, 51, 51);\">&nbsp;</span></h3><h3><span style=\"color: rgb(51, 51, 51);\">This is a product feature announcement message, here is a glimpse of high-level features, you can find plenty of videos on how to use specific features video by visiting the AIV </span><a href="https://www.youtube.com/channel/UCDHSBsTPITUgosWkI8LGH8w" rel=\"noopener noreferrer\" target="_blank" style=\"color: rgb(5, 99, 193);\">YouTube channel</a><span style=\"color: rgb(51, 51, 51);\">.</span></h3><h3><span style=\"color: rgb(51, 51, 51);\">&nbsp;</span></h3><ul><li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Pixel-perfect reports</li><li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Dashboard</li><li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ad-hoc report/analysis</li><li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Web component</li><li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Custom visualization</li><li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Support for BIRT, Jaspersoft, and Pentaho community report designer</li><li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Annotation</li><li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Scheduling and distributions of reports and dashboard</li><li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Embedding</li><li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;SSO/OAuth/SAML support</li><li class=\"ql-align-justify\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Active Directory support, and much more</li></ul><h4><br></h4><h4><strong><em>Active Intelligence Visualization Team</em></strong></h4><p><br></p><p class=\"ql-align-justify\"><a href="https://aivhub.com" rel=\"noopener noreferrer\" target="_blank">Visit AIV</a></p>','Product Features',NULL,NULL,'Announcement Messages','Admin','PVT');
insert into ai_annotation (id,annotationkey,description,shortdescription,startdate,enddate,groupname,owner,visibilitytype) values (4,'Group2','<h4><strong>Dear Customer,</strong></h4><h4> </h4><h4 style=\"text-align: justify;\"><span style=\"color: #808080;\"><strong>Thank you for being our valued customers. We are grateful for the pleasure of serving you and meeting your reporting needs.</strong></span></h4><div><span style=\"color: #808080;\"><strong><br></strong></span></div><h4><span style=\"color: #808080;\"><strong>This is sample group <span style=\"color: #ff6600;\">annotation message</span>. You can create a customize message for specific client.</strong></span></h4><h4><strong>&nbsp;</strong></h4><h4><strong>Active Intelligence Team</strong></h4>','Client Messages',NULL,NULL,'Client Messages','Admin','PVT');
insert into ai_annotation (id,annotationkey,description,shortdescription,startdate,enddate,groupname,owner,visibilitytype) values (5,'Group3','<p><em style=\"background-color: rgb(255, 255, 255);\">This is an example of </em><strong style=\"background-color: rgb(255, 255, 255); color: rgb(255, 102, 0);\"><em>disclaimer annotation messages</em></strong><em style=\"background-color: rgb(255, 255, 255);\">.</em></p><p><br></p><p>This report contains confidential information and is intended solely for the individual to whom it is addressed. </p>','Disclaimer',NULL,NULL,'Disclaimer','Admin','PVT');
insert into ai_annotation (id,annotationkey,description,shortdescription,startdate,enddate,groupname,owner,visibilitytype) values (6,'User-1','<h4><strong style=\"color: gray;\"><em>This is a sample group </em></strong><strong style="color: blue;"><em>annotation message.</em></strong><strong style=\"color: gray;\"><em> You can create a customized message for a specific client.</em></strong></h4><h4><strong style=\"color: rgb(51, 51, 51);\"><em>&nbsp;</em></strong></h4><h4><strong style=\"color: rgb(51, 51, 51);\"><em>Dear User-1,</em></strong></h4><h4><em style=\"color: rgb(51, 51, 51);\">&nbsp;</em></h4><h4 class=\"ql-align-justify\"><strong style=\"color: gray;\"><em>Thank you for being our valued customers. You can create and use this kind of annotation messages which can be customized for different customers to serve individual customer needs and personalized to each of your client/partners and internal users.</em></strong></h4><h4><strong style=\"color: rgb(51, 51, 51);\"><em>&nbsp;</em></strong></h4><h4><strong style=\"color: rgb(51, 51, 51);\"><em>Active Intelligence Visualization Team</em></strong></h4><p><br></p><p><a href="https://aivhub.com" rel=\"noopener noreferrer\" target="_blank">Visit AIV</a></p><h4><br></h4>','Client Messages - User 1',NULL,NULL,'Client Messages','Admin','PVT');
insert into ai_annotation (id,annotationkey,description,shortdescription,startdate,enddate,groupname,owner,visibilitytype) values (7,'User-2','<h4><strong style=\"color: gray;\"><em>This is a sample group </em></strong><strong style="color: rgb(102, 185, 102);"><em><u style=\"background-color: rgb(255, 255, 255);\">annotation message</u></em></strong><strong style=\"color: blue;\"><em>.</em></strong><strong style=\"color: gray;\"><em> You can create a customized message for a specific client.</em></strong></h4><h4><strong><em>&nbsp;</em></strong></h4><h4><strong><em>Dear User-2,</em></strong></h4><h4><em>&nbsp;</em></h4><h4 class=\"ql-align-justify\"><strong style=\"color: gray;\"><em>Thank you for being our valued customers. You can create and use this kind of annotation messages which can be customized for different customers to serve individual customer needs and personalized to each of your client/partners and internal users.</em></strong></h4><h4><strong><em>&nbsp;</em></strong></h4><h4><strong><em>Active Intelligence Visualization Team</em></strong></h4><p><br></p><p><a href="https://aivhub.com" rel=\"noopener noreferrer\" target="_blank" style=\"background-color: rgb(255, 255, 255);\">Visit AIV</a></p><h4><br></h4><h4><br></h4>','Client Messages - User 2',NULL,NULL,'Client Messages','Admin','PVT');

SELECT SETVAL('ai_annotation_id_seq', (SELECT MAX(id) from ai_annotation));
 
Insert into ai_audit (id,resourceid,resourcetype,actiontype,username,starttime,comments,oldvalues,newvalues) values 
(1,'1','FILE','CREATE','Demo',now(),'Folder created',NULL,NULL),
(2,'2','FILE','CREATE','Demo',now(),'Folder created',NULL,NULL),
(3,'3','FILE','CREATE','Demo',now(),'Folder created',NULL,NULL),
(4,'4','FILE','CREATE','Demo',now(),'Folder created',NULL,NULL),
(5,'5','FILE','CREATE','Demo',now(),'Folder created',NULL,NULL),
(6,'6','FILE','CREATE','Demo',now(),'Folder created',NULL,NULL),
(7,'7','FILE','CREATE','Demo',now(),'Folder created',NULL,NULL),
(8,'8','FILE','CREATE','Demo',now(),'Folder created',NULL,NULL),
(9,'9','FILE','CREATE','Demo',now(),'Folder created',NULL,NULL),
(10,'10','FILE','CREATE','Demo',now(),'Folder created',NULL,NULL),
(11,'11','FILE','CREATE','Demo',now(),'Folder created',NULL,NULL),
(12,'12','FILE','CREATE','Demo',now(),'Folder created',NULL,NULL),
(13,'13','FILE','CREATE','Demo',now(),'Folder created',NULL,NULL),
(14,'14','FILE','CREATE','Demo',now(),'Folder created',NULL,NULL),
(15,'15','FILE','CREATE','Demo',now(),'Folder created',NULL,NULL),
(16,'16','FILE','CREATE','Demo',now(),'Folder created',NULL,NULL),
(17,'17','FILE','CREATE','Demo',now(),'Folder created',NULL,NULL),
(18,'18','FILE','CREATE','Demo',now(),'Folder created',NULL,NULL),
(19,'1','SESSION','CREATE','Demo',now(),'Session added',NULL,NULL),
(20,'Admin','USER','CREATE','Demo',now(),'USER added',NULL,NULL),
(21,'19','FILE','CREATE','Admin',now(),'Folder created',NULL,NULL),
(22,'20','FILE','CREATE','Admin',now(),'Folder created',NULL,NULL),
(23,'21','FILE','CREATE','Admin',now(),'Folder created',NULL,NULL),
(24,'22','FILE','CREATE','Admin',now(),'Folder created',NULL,NULL),
(25,'23','FILE','CREATE','Admin',now(),'Folder created',NULL,NULL),
(26,'24','FILE','CREATE','Admin',now(),'Folder created',NULL,NULL),
(27,'25','FILE','CREATE','Admin',now(),'Folder created',NULL,NULL),
(28,'26','FILE','CREATE','Admin',now(),'Folder created',NULL,NULL),
(29,'27','FILE','CREATE','Admin',now(),'Folder created',NULL,NULL),
(30,'28','FILE','CREATE','Admin',now(),'Folder created',NULL,NULL),
(31,'29','FILE','CREATE','Admin',now(),'Folder created',NULL,NULL),
(32,'30','FILE','CREATE','Admin',now(),'Folder created',NULL,NULL),
(33,'31','FILE','CREATE','Admin',now(),'Folder created',NULL,NULL),
(34,'32','FILE','CREATE','Admin',now(),'Folder created',NULL,NULL),
(35,'33','FILE','CREATE','Admin',now(),'Folder created',NULL,NULL),
(36,'34','FILE','CREATE','Admin',now(),'Folder created',NULL,NULL),
(37,'35','FILE','CREATE','Admin',now(),'Folder created',NULL,NULL),
(38,'36','FILE','CREATE','Admin',now(),'Folder created',NULL,NULL),
(39,'Sales','ROLE','CREATE','Admin',now(),'Role added with name:Sales',NULL,NULL),
(40,'Administrator','ROLE','CREATE','Admin',now(),'Role added with name:Administrator',NULL,NULL),
(41,NULL,'ROLE','UPDATE','Admin',now(),'Update roles for user',NULL,NULL),
(42,NULL,'ROLE','UPDATE','Admin',now(),'Update roles for user',NULL,NULL),
(43,'1','ANNOTATION','CREATE','Admin',now(),'Annotation added',NULL,NULL),
(44,'2','ANNOTATION','CREATE','Admin',now(),'Annotation added',NULL,NULL),
(45,'3','ANNOTATION','CREATE','Admin',now(),'Annotation added',NULL,NULL),
(46,'4','ANNOTATION','CREATE','Admin',now(),'Annotation added',NULL,NULL),
(47,'5','ANNOTATION','CREATE','Admin',now(),'Annotation added',NULL,NULL),
(48,'6','ANNOTATION','CREATE','Admin',now(),'Annotation added',NULL,NULL),
(49,'7','ANNOTATION','CREATE','Admin',now(),'Annotation added',NULL,NULL),
(50,'37','FILE','CREATE','Admin',now(),'File created successlly',NULL,NULL),
(51,'37','FILE','UPLOAD','Admin',now(),'File uploaded.',NULL,NULL),
(52,'38','FILE','CREATE','Admin',now(),'File created successlly',NULL,NULL),
(53,'38','FILE','UPLOAD','Admin',now(),'File uploaded.',NULL,NULL),
(54,'39','FILE','CREATE','Admin',now(),'File created successlly',NULL,NULL),
(55,'39','FILE','UPLOAD','Admin',now(),'File uploaded.',NULL,NULL),
(56,'40','FILE','CREATE','Admin',now(),'File created successlly',NULL,NULL),
(57,'40','FILE','UPLOAD','Admin',now(),'File uploaded.',NULL,NULL),
(58,'41','FILE','CREATE','Admin',now(),'File created successlly',NULL,NULL),
(59,'41','FILE','UPLOAD','Admin',now(),'File uploaded.',NULL,NULL),
(60,'42','FILE','CREATE','Admin',now(),'File created successlly',NULL,NULL),
(61,'42','FILE','UPLOAD','Admin',now(),'File uploaded.',NULL,NULL),
(62,'43','FILE','CREATE','Admin',now(),'File created successlly',NULL,NULL),
(63,'43','FILE','UPLOAD','Admin',now(),'File uploaded.',NULL,NULL),
(64,'44','FILE','CREATE','Admin',now(),'File created successlly',NULL,NULL),
(65,'44','FILE','UPLOAD','Admin',now(),'File uploaded.',NULL,NULL),
(66,'45','FILE','CREATE','Admin',now(),'File created successlly',NULL,NULL),
(67,'45','FILE','UPLOAD','Admin',now(),'File uploaded.',NULL,NULL),
(70,'47','FILE','CREATE','Admin',now(),'File created successlly',NULL,NULL),
(71,'47','FILE','UPLOAD','Admin',now(),'File uploaded.',NULL,NULL),
(72,'48','FILE','CREATE','Admin',now(),'File created successlly',NULL,NULL),
(73,'48','FILE','UPLOAD','Admin',now(),'File uploaded.',NULL,NULL),
(74,'49','FILE','CREATE','Admin',now(),'File created successlly',NULL,NULL),
(75,'49','FILE','UPLOAD','Admin',now(),'File uploaded.',NULL,NULL),
(76,'50','FILE','CREATE','Admin',now(),'File created successlly',NULL,NULL),
(77,'50','FILE','UPLOAD','Admin',now(),'File uploaded.',NULL,NULL),
(78,'51','FILE','CREATE','Admin',now(),'File created successlly',NULL,NULL),
(79,'51','FILE','UPLOAD','Admin',now(),'File uploaded.',NULL,NULL),
(80,'52','FILE','CREATE','Admin',now(),'File created successlly',NULL,NULL),
(81,'52','FILE','UPLOAD','Admin',now(),'File uploaded.',NULL,NULL),
(82,'53','FILE','CREATE','Admin',now(),'File created successlly',NULL,NULL),
(83,'53','FILE','UPLOAD','Admin',now(),'File uploaded.',NULL,NULL),
(84,'54','FILE','CREATE','Admin',now(),'File created successlly',NULL,NULL),
(85,'54','FILE','UPLOAD','Admin',now(),'File uploaded.',NULL,NULL),
(86,'55','FILE','CREATE','Admin',now(),'File created successlly',NULL,NULL),
(87,'55','FILE','UPLOAD','Admin',now(),'File uploaded.',NULL,NULL),
(88,'56','FILE','CREATE','Admin',now(),'File created successlly',NULL,NULL),
(89,'56','FILE','UPLOAD','Admin',now(),'File uploaded.',NULL,NULL),
(94,'59','FILE','CREATE','Admin',now(),'Folder created',NULL,NULL),
(95,'60','FILE','CREATE','Admin',now(),'Folder created',NULL,NULL),
(96,'61','FILE','CREATE','Admin',now(),'Folder created',NULL,NULL),
(97,'62','FILE','CREATE','Admin',now(),'Folder created',NULL,NULL),
(98,'63','FILE','CREATE','Admin',now(),'Folder created',NULL,NULL),
(99,'64','FILE','CREATE','Admin',now(),'Folder created',NULL,NULL),
(100,'65','FILE','CREATE','Admin',now(),'File created successlly',NULL,NULL),
(101,'65','FILE','UPLOAD','Admin',now(),'File uploaded.',NULL,NULL),
(102,'66','FILE','CREATE','Admin',now(),'File created successlly',NULL,NULL),
(103,'66','FILE','UPLOAD','Admin',now(),'File uploaded.',NULL,NULL),
(104,'67','FILE','CREATE','Admin',now(),'File created successlly',NULL,NULL),
(105,'67','FILE','UPLOAD','Admin',now(),'File uploaded.',NULL,NULL),
(106,'68','FILE','CREATE','Admin',now(),'File created successlly',NULL,NULL),
(107,'68','FILE','UPLOAD','Admin',now(),'File uploaded.',NULL,NULL),
(108,'69','FILE','CREATE','Admin',now(),'File created successlly',NULL,NULL),
(109,'69','FILE','UPLOAD','Admin',now(),'File uploaded.',NULL,NULL),
(110,'70','FILE','CREATE','Admin',now(),'File created successlly',NULL,NULL),
(111,'70','FILE','UPLOAD','Admin',now(),'File uploaded.',NULL,NULL),
(112,'71','FILE','CREATE','Admin',now(),'File created successlly',NULL,NULL),
(113,'71','FILE','UPLOAD','Admin',now(),'File uploaded.',NULL,NULL),
(114,'72','FILE','CREATE','Admin',now(),'File created successlly',NULL,NULL),
(115,'72','FILE','UPLOAD','Admin',now(),'File uploaded.',NULL,NULL),
(116,'73','FILE','CREATE','Admin',now(),'File created successlly',NULL,NULL),
(117,'73','FILE','UPLOAD','Admin',now(),'File uploaded.',NULL,NULL),
(118,'74','FILE','CREATE','Admin',now(),'File created successlly',NULL,NULL),
(119,'74','FILE','UPLOAD','Admin',now(),'File uploaded.',NULL,NULL),
(120,'75','FILE','CREATE','Admin',now(),'File created successlly',NULL,NULL),
(121,'75','FILE','UPLOAD','Admin',now(),'File uploaded.',NULL,NULL),
(122,'76','FILE','CREATE','Admin',now(),'File created successlly',NULL,NULL),
(123,'76','FILE','UPLOAD','Admin',now(),'File uploaded.',NULL,NULL),
(124,'77','FILE','CREATE','Admin',now(),'File created successlly',NULL,NULL),
(125,'77','FILE','UPLOAD','Admin',now(),'File uploaded.',NULL,NULL),
(126,'78','FILE','CREATE','Admin',now(),'File created successlly',NULL,NULL),
(127,'78','FILE','UPLOAD','Admin',now(),'File uploaded.',NULL,NULL),
(128,'79','FILE','CREATE','Admin',now(),'File created successlly',NULL,NULL),
(129,'79','FILE','UPLOAD','Admin',now(),'File uploaded.',NULL,NULL),
(130,'80','FILE','CREATE','Admin',now(),'File created successlly',NULL,NULL),
(131,'80','FILE','UPLOAD','Admin',now(),'File uploaded.',NULL,NULL),
(132,'81','FILE','CREATE','Admin',now(),'Folder created',NULL,NULL),
(133,'82','FILE','CREATE','Admin',now(),'File created successlly',NULL,NULL),
(134,'82','FILE','UPLOAD','Admin',now(),'File uploaded.',NULL,NULL),
(135,'83','FILE','CREATE','Admin',now(),'File created successlly',NULL,NULL),
(136,'83','FILE','UPLOAD','Admin',now(),'File uploaded.',NULL,NULL),
(137,'84','FILE','CREATE','Admin',now(),'Folder created',NULL,NULL),
(138,'85','FILE','CREATE','Admin',now(),'Folder created',NULL,NULL),
(139,'86','FILE','CREATE','Admin',now(),'File created successlly',NULL,NULL),
(140,'86','FILE','UPLOAD','Admin',now(),'File uploaded.',NULL,NULL),
(141,'87','FILE','CREATE','Admin',now(),'File created successlly',NULL,NULL),
(142,'87','FILE','UPLOAD','Admin',now(),'File uploaded.',NULL,NULL),
(143,'88','FILE','CREATE','Admin',now(),'File created successlly',NULL,NULL),
(144,'88','FILE','UPLOAD','Admin',now(),'File uploaded.',NULL,NULL),
(145,'89','FILE','CREATE','Admin',now(),'File created successlly',NULL,NULL),
(146,'89','FILE','UPLOAD','Admin',now(),'File uploaded.',NULL,NULL),
(147,'90','FILE','CREATE','Demo',now(),'Folder created',NULL,NULL),
(148,'91','FILE','CREATE','Admin',now(),'Folder created',NULL,NULL),
(149,'92','FILE','CREATE','Demo',now(),'Folder created',NULL,NULL),
(150,'93','FILE','CREATE','Admin',now(),'Folder created',NULL,NULL),
(151,'94','FILE','UPLOAD','Admin',now(),'File uploaded.',NULL,NULL),
(152,'95','FILE','UPLOAD','Admin',now(),'File uploaded.',NULL,NULL),
(153,'96','FILE','UPLOAD','Admin',now(),'File uploaded.',NULL,NULL);

 SELECT SETVAL('ai_audit_id_seq', (SELECT MAX(id) from ai_audit));

insert into ai_filefolder_output(fileid,outputtype) values (49,'pdf');

insert into ai_parameter(id,name,datatype,format,displayname,displaytype,defaultvalue,defaultvaluetype,helptext,isvisible,isrequired,filterby,filtercondition,linkedparam,datasetid,datasetcolumnname,value_displaytext,username) values 
(1,'All Country','String','custom','All Country','ListBox',null,'DYNAMIC',null,1,1,'None',null,'None',40,'country','country','Admin');

SELECT SETVAL('ai_parameter_id_seq', (SELECT MAX(id) from ai_parameter));

insert into ai_privilege(id,fileid,privilegetype,user_rolename,privilegevalue) values 
(1,37,'ROLE','Sales',NULL),
(2,38,'ROLE','Sales',NULL),
(3,39,'ROLE','Sales',NULL),
(4,40,'ROLE','Sales',NULL),
(5,41,'ROLE','Sales',NULL),
(6,42,'ROLE','Sales',NULL),
(7,43,'ROLE','Sales',NULL),
(8,44,'ROLE','Sales',NULL),
(9,45,'ROLE','Sales',NULL),
(11,47,'ROLE','Sales',NULL),
(12,48,'ROLE','Sales',NULL),
(13,49,'ROLE','Sales',NULL),
(14,50,'ROLE','Sales',NULL),
(15,51,'ROLE','Sales',NULL),
(16,52,'ROLE','Sales',NULL),
(17,53,'ROLE','Sales',NULL),
(18,54,'ROLE','Sales',NULL),
(19,55,'ROLE','Sales',NULL),
(20,56,'ROLE','Sales',NULL),
(23,86,'ROLE','Sales',NULL),
(24,88,'ROLE','Sales',NULL),
(25,89,'ROLE','Sales',NULL);

SELECT SETVAL('ai_privilege_id_seq', (SELECT MAX(id) from ai_privilege));

INSERT INTO ai_datasource_type(id, protocol, type_database,driver_class_name,url)
VALUES (1,'jdbc','mysql','com.mysql.jdbc.Driver','jdbc:mysql://<hostname>:<port>/<dbname>'),
(2,'jdbc','oracle','oracle.jdbc.driver.OracleDriver','jdbc:oracle:thin:@<hostname>:<port>/<service_name>'),
(3,'jdbc','postgresql','org.postgresql.Driver','jdbc:postgresql://<hostname>:<port>/<dbname>'),
(4,'jdbc','mssql','com.microsoft.sqlserver.jdbc.SQLServerDriver','jdbc:sqlserver://<hostname>:<port>;databaseName=<dbname>'),
(5,'olap','mondrain','mondrian.olap4j.MondrianOlap4jDriver',NULL),
(6,'olap','mssqlcube',NULL,NULL),
(7,'olap','hsqldb','org.hsqldb.jdbcDriver','java:comp/env/jdbc/SampleData'),
(8,'nosql','mongodb','mongodb.jdbc.MongoDriver','mongodb://<servername>:<port>/<databaseName>'),
(9,'nosql','hive','org.apache.hive.jdbc.HiveDriver','jdbc:hive2://<hostname>:<port>/<db>');

SELECT SETVAL('ai_datasource_type_id_seq', (SELECT MAX(id) from ai_datasource_type));

INSERT INTO ai_lovrow_mapping(id,lovId,mapId,rowNo,owner,comments)
VALUES (1,44,86,'0','Admin',null),
(2,44,86,'1','Admin',null),
(3,44,86,'2','Admin',null);

SELECT SETVAL('ai_lovrow_mapping_id_seq', (SELECT MAX(id) from ai_lovrow_mapping));


INSERT INTO ai_department(id,deptName,deptCode)
VALUES (1,'Default','Default');

SELECT SETVAL('ai_department_id_seq', (SELECT MAX(id) from ai_department));

commit;
