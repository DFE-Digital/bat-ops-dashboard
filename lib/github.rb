require 'octokit'
require_relative 'deployment'

class GitHub
  DEPLOY_WORKFLOW = 'deploy.yml'.freeze
  BUILD_WORKFLOW = 'build.yml'.freeze
  HOTFIX_BRANCH = 'hotfix'.freeze
  ORG = Rails.configuration.github['org'].freeze

  def self.client
    @client ||= Octokit::Client.new(access_token: ENV['GITHUB_TOKEN'])
  end

  def self.deployments(name, environment)
    options = { environment: environment, per_page: 20, page: 1, task: 'deploy' }
    repo = "#{ORG}/#{name}"
    deployments = client.deployments(repo, options)
    return nil if deployments&.length&.zero?

    deployments.map { |deployment| Deployment.new(deployment) }
  end

  def self.latest_deployment(name, environment)
    deployments(name, environment).first
  end

  def self.link_for_sha(name, sha)
    repo = "#{ORG}/#{name}"
    client.commit(repo, sha)['html_url']
  end
end
