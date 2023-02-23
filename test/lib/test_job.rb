require 'test_helper'

class TestJob < Minitest::Test

  def setup
    options = {
      :username => 'myusername',
      :password => 'mypassword'
    }

    @client = SalesforceBulk::Client.new(options)
    @job = SalesforceBulk::Job.new
    @headers = {'Content-Type' => 'application/xml', 'X-Sfdc-Session' => '123456789'}

    bypass_authentication(@client)
  end

  test "initialization from XML" do
    xml = fixture("job_info_response.xml")
    job = SalesforceBulk::Job.new_from_xml(XmlSimple.xml_in(xml, 'ForceArray' => false))

    assert_equal job.id, '750E00000004N1mIAE'
    assert_equal job.operation, 'upsert'
    assert_equal job.sobject, 'VideoEvent__c'
    assert_equal job.created_by, '005E00000017spfIAA'
    assert_equal job.created_at, DateTime.parse('2012-05-30T04:08:30.000Z')
    assert_equal job.completed_at, DateTime.parse('2012-05-30T04:08:30.000Z')
    assert_equal job.state, 'Open'
    assert_equal job.external_id_field_name, 'Id__c'
    assert_equal job.concurrency_mode, 'Parallel'
    assert_equal job.content_type, 'CSV'
    assert_equal job.queued_batches, 0
    assert_equal job.in_progress_batches, 0
    assert_equal job.completed_batches, 0
    assert_equal job.failed_batches, 0
    assert_equal job.total_batches, 0
    assert_equal job.processed_records, 0
    assert_equal job.failed_records, 0
    assert_equal job.retries, 0
    assert_equal job.api_active_processing_time, 0
    assert_equal job.apex_processing_time, 0
    assert_equal job.total_processing_time, 0
    assert_equal job.api_version, 24.0
  end

  test "state?" do
    @job.state = 'Closed'
    assert @job.state?('closed')

    @job.state = 'Closed'
    assert @job.state?('CLOSED')

    @job.state = nil
    assert !@job.state?('closed')
  end

  test "aborted?" do
    @job.state = 'Aborted'
    assert @job.aborted?

    @job.state = nil
    assert !@job.aborted?
  end

  test "closed?" do
    @job.state = 'Closed'
    assert @job.closed?

    @job.state = nil
    assert !@job.closed?
  end

  test "open?" do
    @job.state = 'Open'
    assert @job.open?

    @job.state = nil
    assert !@job.open?
  end

  test "add_job returns successful response" do
    request = fixture("job_create_request.xml")
    response = fixture("job_create_response.xml")

    stub_request(:post, "#{api_url(@client)}job").with(:body => request, :headers => @headers).to_return(:body => response, :status => 200)

    job = @client.add_job(:upsert, :VideoEvent__c, :external_id_field_name => :Id__c)

    assert_requested :post, "#{api_url(@client)}job", :body => request, :headers => @headers, :times => 1

    assert_equal job.id, '750E00000004MzbIAE'
    assert_equal job.operation, 'upsert'
    assert_equal job.sobject, 'VideoEvent__c'
    assert_equal job.created_by, '005E00000017spfIAA'
    assert_equal job.created_at, DateTime.parse('2012-05-29T21:50:47.000Z')
    assert_equal job.completed_at, DateTime.parse('2012-05-29T21:50:47.000Z')
    assert_equal job.state, 'Open'
    assert_equal job.external_id_field_name, 'Id__c'
    assert_equal job.concurrency_mode, 'Parallel'
    assert_equal job.content_type, 'CSV'
    assert_equal job.queued_batches, 0
    assert_equal job.in_progress_batches, 0
    assert_equal job.completed_batches, 0
    assert_equal job.failed_batches, 0
    assert_equal job.total_batches, 0
    assert_equal job.processed_records, 0
    assert_equal job.failed_records, 0
    assert_equal job.retries, 0
    assert_equal job.api_active_processing_time, 0
    assert_equal job.apex_processing_time, 0
    assert_equal job.total_processing_time, 0
    assert_equal job.api_version, 24.0
  end

  test "add_job raises ArgumentError if provided with invalid operation" do
    assert_raises ArgumentError do
      @client.add_job(:SomeOtherOperation, nil)
    end
  end

  test "add_job raises ArgumentError if provided with invalid key for options" do
    assert_raises ArgumentError do
      @client.add_job(:upsert, :VideoEvent__c, :non_existing_key => '')
    end
  end

  test "add_job raises ArgumentError if provided with invalid concurrency mode" do
    assert_raises ArgumentError do
      @client.add_job(:upsert, :VideoEvent__c, :concurrency_mode => 'SomeMode')
    end
  end

  test "should close job and return successful response" do
    request = fixture("job_close_request.xml")
    response = fixture("job_close_response.xml")
    job_id = "750E00000004MzbIAE"

    stub_request(:post, "#{api_url(@client)}job/#{job_id}").with(:body => request, :headers => @headers).to_return(:body => response, :status => 200)

    job = @client.close_job(job_id)

    assert_requested :post, "#{api_url(@client)}job/#{job_id}", :body => request, :headers => @headers, :times => 1

    assert_equal job.id, job_id
    assert_equal job.operation, 'upsert'
    assert_equal job.sobject, 'VideoEvent__c'
    assert_equal job.created_by, '005E00000017spfIAA'
    assert_equal job.created_at, DateTime.parse('2012-05-29T23:51:53.000Z')
    assert_equal job.completed_at, DateTime.parse('2012-05-29T23:51:53.000Z')
    assert_equal job.state, 'Closed'
    assert_equal job.external_id_field_name, 'Id__c'
    assert_equal job.concurrency_mode, 'Parallel'
    assert_equal job.content_type, 'CSV'
    assert_equal job.queued_batches, 0
    assert_equal job.in_progress_batches, 0
    assert_equal job.completed_batches, 0
    assert_equal job.failed_batches, 0
    assert_equal job.total_batches, 0
    assert_equal job.processed_records, 0
    assert_equal job.failed_records, 0
    assert_equal job.retries, 0
    assert_equal job.api_active_processing_time, 0
    assert_equal job.apex_processing_time, 0
    assert_equal job.total_processing_time, 0
    assert_equal job.api_version, 24.0
  end

  test "should abort job and return successful response" do
    request = fixture("job_abort_request.xml")
    response = fixture("job_abort_response.xml")
    job_id = "750E00000004N1NIAU"

    stub_request(:post, "#{api_url(@client)}job/#{job_id}").with(:body => request, :headers => @headers).to_return(:body => response, :status => 200)

    job = @client.abort_job(job_id)

    assert_requested :post, "#{api_url(@client)}job/#{job_id}", :body => request, :headers => @headers, :times => 1

    assert_equal job.id, job_id
    assert_equal job.operation, 'upsert'
    assert_equal job.sobject, 'VideoEvent__c'
    assert_equal job.created_by, '005E00000017spfIAA'
    assert_equal job.created_at, DateTime.parse('2012-05-30T00:16:04.000Z')
    assert_equal job.completed_at, DateTime.parse('2012-05-30T00:16:04.000Z')
    assert_equal job.state, 'Aborted'
    assert_equal job.external_id_field_name, 'Id__c'
    assert_equal job.concurrency_mode, 'Parallel'
    assert_equal job.content_type, 'CSV'
    assert_equal job.queued_batches, 0
    assert_equal job.in_progress_batches, 0
    assert_equal job.completed_batches, 0
    assert_equal job.failed_batches, 0
    assert_equal job.total_batches, 0
    assert_equal job.processed_records, 0
    assert_equal job.failed_records, 0
    assert_equal job.retries, 0
    assert_equal job.api_active_processing_time, 0
    assert_equal job.apex_processing_time, 0
    assert_equal job.total_processing_time, 0
    assert_equal job.api_version, 24.0
  end

  test "should return job info" do
    response = fixture("job_info_response.xml")
    job_id = "750E00000004N1mIAE"

    stub_request(:get, "#{api_url(@client)}job/#{job_id}").with(:body => '', :headers => @headers).to_return(:body => response, :status => 200)

    job = @client.job_info(job_id)

    assert_requested :get, "#{api_url(@client)}job/#{job_id}", :body => '', :headers => @headers, :times => 1

    assert_equal job.id, job_id
    assert_equal job.operation, 'upsert'
    assert_equal job.sobject, 'VideoEvent__c'
    assert_equal job.created_by, '005E00000017spfIAA'
    assert_equal job.created_at, DateTime.parse('2012-05-30T04:08:30.000Z')
    assert_equal job.completed_at, DateTime.parse('2012-05-30T04:08:30.000Z')
    assert_equal job.state, 'Open'
    assert_equal job.external_id_field_name, 'Id__c'
    assert_equal job.concurrency_mode, 'Parallel'
    assert_equal job.content_type, 'CSV'
    assert_equal job.queued_batches, 0
    assert_equal job.in_progress_batches, 0
    assert_equal job.completed_batches, 0
    assert_equal job.failed_batches, 0
    assert_equal job.total_batches, 0
    assert_equal job.processed_records, 0
    assert_equal job.failed_records, 0
    assert_equal job.retries, 0
    assert_equal job.api_active_processing_time, 0
    assert_equal job.apex_processing_time, 0
    assert_equal job.total_processing_time, 0
    assert_equal job.api_version, 24.0
  end

  test "should raise SalesforceError on invalid job" do
    response = fixture("invalid_job_error.xml")

    stub_request(:post, "#{api_url(@client)}job").to_return(:body => response, :status => 500)

    error = assert_raises SalesforceBulk::SalesforceError do
      @client.add_job(:upsert, :SomeNonExistingObject__c, :external_id_field_name => :Id__c)
    end

    assert_equal '500', error.error_code
    assert_equal 'Unable to find object: Video__c', error.message
    assert_equal 'InvalidJob', error.exception_code
  end

  test "should raise SalesforceError on invalid session response" do
    response = fixture("invalid_session_error.xml")

    stub_request(:post, "#{api_url(@client)}job").to_return(:body => response, :status => 400)

    error = assert_raises SalesforceBulk::SalesforceError do
      @client.add_job(:upsert, :SomeNonExistingObject__c, :external_id_field_name => :Id__c)
    end

    assert_equal '400', error.error_code
    assert_equal 'Invalid session id', error.message
    assert_equal 'InvalidSessionId', error.exception_code
  end
end
